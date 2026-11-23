#!/usr/bin/env bash
# 枝を選び、根から選んだ item までの経路と、選んだ item の下流を順に表示して、人の確認を verified に記録する。
#
#   sara-verify [--all]
#
# exit code は 0 = 終えた・中断した / 2 = 引数の誤り・端末でない・sara check の失敗・<id> の誤り・
# 対象のファイルに未コミットの変更がある・verified を書けない・fzf の失敗。
#
# 次の環境変数は、契約テスト（dev/tests/sara-verify.sh）の中だけで使う差し替えである。
#   SARA_VERIFY_FZF   fzf の代わりに呼ぶコマンド
#   SARA_VERIFY_LEAF  leaf の代わりに呼ぶコマンド
#   SARA_VERIFY_TTY   1 なら、stdin と stdout が端末であるとみなす

set -euo pipefail

usage() {
  cat >&2 <<'EOF'
usage: sara-verify [--all]

solution から始めて、子の item（その item を上流の relation で指している item）を 1 段ずつ fzf で選ぶ。
どの段でも、いま選んでいる item で決められる。辿る relation は refines / derives_from / satisfies /
threatens / mitigates / covers / follows。

確認の対象は、根から選んだ item までの経路の item と、選んだ item の下流のすべて。幅優先で並べ、
同じ深さの中は ID の順にする。複数の親から届く item は最初の 1 度だけ対象にする。status が deprecated の
item と、generated.at 以降の human: の verified を持つ item は対象から外す。

item ごとに leaf で表示し、閉じたら「記録する・飛ばす・中断する」を選ぶ。solution と use_case では、
選ぶ前に review_question_for がその型を指す quality の item の確認の問いを出す。「記録する」では EDITOR で
コメントを任意で書き（# で始まる行は除く）、frontmatter の verified に by: "human:<id>" と at の要素を足す。
<id> は SARA_VERIFY_HUMAN_ID、無ければ gh api user --jq .login の出力。

options:
  --all  generated.at 以降の human: の verified を持つ item も対象にする

exit code:
  0  対象を終えた、または中断した
  2  引数の誤り・stdin か stdout が端末でない・sara check の失敗・<id> を決められない・
     対象のファイルに未コミットの変更がある・verified を書けない・fzf の失敗
EOF
}

all=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    -h | --help)
      usage
      exit 0
      ;;
    --all) all=1 ;;
    *)
      usage
      exit 2
      ;;
  esac
  shift
done

die() {
  echo "sara-verify: $1" >&2
  exit 2
}

if [ "${SARA_VERIFY_TTY-}" != 1 ] && { [ ! -t 0 ] || [ ! -t 1 ]; }; then
  die "stdin と stdout が端末のときだけ動く"
fi

fzf_cmd=${SARA_VERIFY_FZF:-fzf}
leaf_cmd=${SARA_VERIFY_LEAF:-leaf}

repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || die "git のリポジトリの中で実行すること"
cd "$repo_root"

if ! graph=$(sara check --format json) || ! printf '%s' "$graph" | jq -e '.valid == true and (.items | type) == "array"' >/dev/null; then
  die "sara check が失敗した（先にグラフを valid にすること）"
fi

if [ -n "${SARA_VERIFY_HUMAN_ID+x}" ]; then
  human_id=$SARA_VERIFY_HUMAN_ID
else
  human_id=$(gh api user --jq .login) || die "gh api user で <id> を得られない"
fi
case "$human_id" in
  '' | *$'\n'* | *'"'* | *\\*) die "<id> が空か、改行・二重引用符・バックスラッシュを含む" ;;
esac

# generated と verified は sara の fields に出ないため、各 item の frontmatter から読む（sara-fresh と同じ読み方）。
mapfile -t files < <(printf '%s' "$graph" | jq -r '.items[].file')
frontmatter=$(awk '
    function quote(s) { gsub(/\047/, "\047\047", s); return "\047" s "\047" }
    FNR == 1 {
      print "---"
      print "__file: " quote(FILENAME)
      if ($0 != "---") nextfile
      next
    }
    $0 == "---" { nextfile }
    { print }
  ' "${files[@]}" | yq -o=json -I=0 '{"file": .__file, "generated": .generated, "verified": .verified}') ||
  die "frontmatter を YAML として読めない item がある"

# item ごとに、上流の ID・確認済みか・確認の問いに使うフィールドをまとめる。
items=$(printf '%s' "$graph" | jq -c --slurpfile fm <(printf '%s\n' "$frontmatter") --argjson all "$all" '
  def epoch:
    if type != "string" then null
    else (capture("^(?<d>[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2})(?<f>\\.[0-9]+)?(?<z>Z|(?<s>[+-])(?<h>[0-9]{2}):(?<m>[0-9]{2}))$")
          | (try ((.d + "Z") | fromdateiso8601) catch null) as $t
          | if $t == null then null
            else $t + ("0" + (.f // "") | tonumber)
              - (if .z == "Z" then 0
                 else ((.h | tonumber) * 3600 + (.m | tonumber) * 60) * (if .s == "+" then 1 else -1 end) end)
            end) // null
    end;
  ($fm | map({key: .file, value: .}) | from_entries) as $by_file
  | [.items[]
     | ($by_file[.file] // {}) as $f
     | ($f.generated.at? | epoch) as $g
     | {id, type, name, file: (.file | ltrimstr("./")),
        status: .fields.status?,
        question_for: .fields.review_question_for?,
        question: .fields.specification_ja?,
        ups: [.relations // {} | (.refines, .derives_from, .satisfies, .threatens, .mitigates, .covers, .follows) // [] | .[]],
        verified: ($g != null and ([($f.verified // []) | if type == "array" then .[] else empty end
          | select(((.by? // "") | startswith("human:")) and ((.at? | epoch) // -1) >= $g)] | length > 0))}
     | . + {target: (.status != "deprecated" and ($all == 1 or (.verified | not)))}]') ||
  die "sara check の JSON と frontmatter を突き合わせられない"

# fzf を呼び、選んだ行を出す。Ctrl-C は exit 130 のまま返す。
pick() {
  local rc=0 line
  line=$("$fzf_cmd" --delimiter=$'\t' "$@") || rc=$?
  if [ "$rc" -eq 130 ]; then return 130; fi
  [ "$rc" -eq 0 ] || die "fzf が失敗した（exit $rc）"
  printf '%s' "$line"
}

on_interrupt() {
  echo "sara-verify: 中断した" >&2
  exit 130
}
trap on_interrupt INT

# pick の exit code を受ける。130 は Ctrl-C として中断し、それ以外はそのまま終える。
stop_on() {
  [ "$1" -ne 130 ] || on_interrupt
  exit "$1"
}

# 根の solution を決め、子を 1 段ずつ選ぶ。
roots=$(jq -r '[.[] | select(.type == "solution")] | sort_by(.id)[] | [.id, .type, .name] | @tsv' <<<"$items")
[ -n "$roots" ] || die "solution が無い"
if [ "$(wc -l <<<"$roots")" -eq 1 ]; then
  current=${roots%%$'\t'*}
else
  current=$(pick --header "根の solution を選ぶ" <<<"$roots") || stop_on $?
  current=${current%%$'\t'*}
fi
path=("$current")
decide_line=$'=\tこの item で決める'
while :; do
  children=$(jq -r --arg id "$current" '[.[] | select(.ups | index($id))] | sort_by(.id)[] | [.id, .type, .name, (.status // "")] | @tsv' <<<"$items")
  [ -n "$children" ] || break
  header=$(jq -r --arg id "$current" '.[] | select(.id == $id) | "いま: \(.id) \(.name)"' <<<"$items")
  line=$(pick --header "$header" <<<"$decide_line"$'\n'"$children") || stop_on $?
  [ "${line%%$'\t'*}" != = ] || break
  current=${line%%$'\t'*}
  path+=("$current")
done

# 経路のあとに、選んだ item の下流を層ごとに ID の順で並べる。複数の親から届く item は初出の層に置く。
mapfile -t targets < <(jq -r --args '
  . as $items
  | ($items | map({key: .id, value: .}) | from_entries) as $by_id
  | def down($level; $seen):
      if ($level | length) == 0 then []
      else ([$items[] | select(.id as $c | ($seen | index($c) | not)) | select(any(.ups[]; . as $u | $level | index($u)))]
            | map(.id) | sort) as $next
        | $next + down($next; $seen + $next)
      end;
  ($ARGS.positional + down([$ARGS.positional[-1]]; $ARGS.positional))[]
  | $by_id[.] | select(.target) | [.file, .type, .id] | @tsv' "${path[@]}" <<<"$items")

if [ "${#targets[@]}" -eq 0 ]; then
  echo "sara-verify: 対象の item が無い" >&2
  exit 0
fi

# 標準入力の item の frontmatter の verified に要素を足して出す。verified がインラインの形なら exit 3。
add_verified() {
  awk -v by="human:$1" -v at="$2" '
    function emit() {
      if (!indset) ind = "  "
      print ind "- by: \"" by "\""
      print ind "  at: \"" at "\""
      done = 1
      inblk = 0
    }
    NR == 1 { print; next }
    closed { print; next }
    /^---[ \t]*$/ {
      if (!done) { if (!seen) print "verified:"; emit() }
      closed = 1; print; next
    }
    inblk && /^[^ \t#-]/ { emit() }
    inblk && !indset && /^[ \t]*- / { match($0, /^[ \t]*/); ind = substr($0, 1, RLENGTH); indset = 1 }
    !seen && /^verified:/ {
      if ($0 !~ /^verified:[ \t]*$/) exit 3
      seen = 1; inblk = 1
    }
    { print }
  '
}

# 始める前に、対象のファイルの未コミットの変更と verified の形を確かめる。
target_files=()
for t in "${targets[@]}"; do target_files+=("${t%%$'\t'*}"); done
dirty=$(git status --porcelain -- "${target_files[@]}")
[ -z "$dirty" ] || die "対象のファイルに未コミットの変更がある:"$'\n'"$dirty"
for f in "${target_files[@]}"; do
  add_verified x x <"$f" >/dev/null || die "$f の verified がブロックのリストでない"
done

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

recorded_files=()
recorded_types=()
recorded_comments=()

for t in "${targets[@]}"; do
  IFS=$'\t' read -r file type id <<<"$t"
  "$leaf_cmd" "$file"

  questions=''
  if [ "$type" = solution ] || [ "$type" = use_case ]; then
    questions=$(jq -r --arg t "$type" '[.[] | select(.question_for == $t and .status != "deprecated")] | sort_by(.id)[]
      | "確認の問い（\(.name)）:", (.question // "" | rtrimstr("\n"))' <<<"$items")
    [ -z "$questions" ] || printf '%s\n' "$questions"
  fi

  choice=$(pick --header "$id $file" <<<$'記録する\n飛ばす\n中断する') || stop_on $?
  case "$choice" in
    飛ばす) continue ;;
    中断する) break ;;
  esac

  msg="$tmp/comment"
  {
    printf '# %s に人の確認を記録する。コメントは任意。# で始まる行はコメントから除く。\n' "$file"
    [ -z "$questions" ] || sed 's/^/# /' <<<"$questions"
  } >|"$msg"
  sh -c "${EDITOR:-vi}"' "$1"' sh "$msg" || die "EDITOR が失敗した"
  # # の行を除き、前後の空行を落とす。
  comment=$(awk '/^#/ { next } { line[++n] = $0 } NF && !first { first = n } NF { last = n }
    END { for (i = first; first && i <= last; i++) print line[i] }' "$msg")

  before=$(yq --front-matter=extract '.verified | length' "$file")
  at=$(date +%Y-%m-%dT%H:%M:%S%:z)
  add_verified "$human_id" "$at" <"$file" >|"$tmp/item" || die "$file の verified を書けない"
  cp "$file" "$tmp/orig"
  cat "$tmp/item" >|"$file"
  if [ "$(yq --front-matter=extract '.verified | length' "$file" 2>/dev/null)" != $((before + 1)) ] ||
    [ "$(yq --front-matter=extract '.verified[-1].by + " " + .verified[-1].at' "$file" 2>/dev/null)" != "human:$human_id $at" ]; then
    cat "$tmp/orig" >|"$file"
    die "$file の verified を書けない（元に戻した）"
  fi
  echo "sara-verify: $file に人の確認を記録した" >&2
  recorded_files+=("$file")
  recorded_types+=("$type")
  recorded_comments+=("$comment")
done

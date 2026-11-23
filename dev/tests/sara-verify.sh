#!/usr/bin/env bash
# sara-verify（枝を選んで上流から順に item を表示し、人の確認を記録するコマンド）の検証。
# item と sara.toml は一時ディレクトリの git のリポジトリに作り、実物の docs/model.yaml を重ねる。
# fzf・leaf・EDITOR・端末の判定はスタブへ差し替える。
#
# 実行:
#   nix develop '.?dir=dev#sara' -c bash dev/tests/sara-verify.sh
set -uo pipefail

fail=0
pass() { printf 'ok   - %s\n' "$1"; }
fault() {
  printf 'FAIL - %s\n' "$1"
  fail=1
}

assert_eq() {
  if [[ "$2" == "$3" ]]; then
    pass "$1"
  else
    fault "$1（期待: $2 実際: $3）"
  fi
}

assert_has() {
  if grep -Fq -- "$2" <<<"$3"; then
    pass "$1"
  else
    fault "$1（$2 が無い）"
  fi
}

assert_lacks() {
  if ! grep -Fq -- "$2" <<<"$3"; then
    pass "$1"
  else
    fault "$1（$2 が出ている）"
  fi
}

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

contract_root="$(git rev-parse --show-toplevel 2>/dev/null || printf '.')"
model_yaml="$contract_root/docs/model.yaml"
if [[ ! -f "$model_yaml" ]]; then
  fault "docs/model.yaml を解決できない（model.yaml=$model_yaml）"
  exit 1
fi

# 手元の git の設定（署名・hook など）を持ち込まない。
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1

# --- スタブ ---------------------------------------------------------------------

mkdir -p "$work/bin"
# fzf: キューの先頭の行を取り出し、候補のうちそれを含む最初の行を出す。
# __INT__ は Ctrl-C（exit 130）。キューが尽きたら 98、候補に無ければ 99 で落ちる。
cat >"$work/bin/fzf" <<'SH'
#!/usr/bin/env bash
candidates=$(cat)
pattern=$(head -n 1 "$STUB_QUEUE")
[[ -s "$STUB_QUEUE" ]] || exit 98
sed -i 1d "$STUB_QUEUE"
[[ "$pattern" != __INT__ ]] || exit 130
grep -F -m 1 -- "$pattern" <<<"$candidates" || exit 99
SH
# leaf: 表示したファイルを記録する。STUB_LEAF_INT に一致するファイルでは呼び出し元へ SIGINT を送る。
cat >"$work/bin/leaf" <<'SH'
#!/usr/bin/env bash
printf '%s\n' "$1" >>"$STUB_LEAF_LOG"
if [[ -n "${STUB_LEAF_INT-}" && "$1" == "$STUB_LEAF_INT" ]]; then kill -INT "$PPID"; fi
SH
# EDITOR: 初期の文面をログへ写し、STUB_COMMENT を書き足す（# の行は残したまま）。
cat >"$work/bin/editor" <<'SH'
#!/usr/bin/env bash
{ printf '=== %s\n' "$1"; cat "$1"; } >>"$STUB_EDITOR_LOG"
printf '%s' "${STUB_COMMENT-}" >>"$1"
SH
chmod +x "$work/bin/"*

# --- グラフの組み立て ----------------------------------------------------------

SOL="SOL-5011a001-0000-4000-8000-000000000001"
UC_A="UC-0ca11001-0000-4000-8000-000000000001"
UC_B="UC-0ca11002-0000-4000-8000-000000000002"
UC_DEP="UC-0ca11003-0000-4000-8000-000000000003"
QA_SOL="QA-9a000001-0000-4000-8000-000000000001"
QA_UC="QA-9a000002-0000-4000-8000-000000000002"
REQ_1="REQ-aaaa0001-0000-4000-8000-000000000001"
REQ_2="REQ-aaaa0002-0000-4000-8000-000000000002"
REQ_3="REQ-aaaa0003-0000-4000-8000-000000000003"
REQ_M="REQ-aaaa0004-0000-4000-8000-000000000004"
REQ_4="REQ-aaaa0005-0000-4000-8000-000000000005"
DSG_0="DSG-dd000000-0000-4000-8000-000000000000"
DSG_1="DSG-dd000001-0000-4000-8000-000000000001"

# <リポジトリ> <ファイル名> <ID> <型> <name> の item を書く。frontmatter の残りは標準入力から受ける。
item() {
  local repo=$1 file=$2 id=$3 type=$4 name=$5
  {
    printf -- '---\nid: "%s"\ntype: %s\nname: "%s"\n' "$id" "$type" "$name"
    cat
    printf -- '---\n# %s\n\n本文。\n' "$name"
  } >"$repo/docs/$file.md"
}

gen='generated:
  by: "claude-code/fixture"
  at: "2026-03-01T00:00:00+09:00"'
req='specification: |
  The fixture SHALL keep this requirement.
specification_ja: |
  fixture はこの要求を保たなければならない。
section: product-scope'

# 経路と下流（REQ_1・REQ_M から届く DSG_1）、ID の順（DSG_0 < DSG_1）、deprecated（UC_DEP・REQ_3）、
# 確認済み（REQ_2）、verified の後ろに別のキーが続く item（REQ_4）を 1 つのグラフに置く。
make_repo() {
  local repo=$1
  mkdir -p "$repo/docs"
  cp "$model_yaml" "$repo/model.yaml"
  cat >"$repo/sara.toml" <<'TOML'
model_schema = "model.yaml"

[repositories]
paths = ["./docs"]

[validation]
strict_mode = true
TOML
  item "$repo" sol "$SOL" solution "根" <<YAML
status: stable
stale_after: "2027-01-01T00:00:00+09:00"
$gen
YAML
  item "$repo" uc-a "$UC_A" use_case "ユースケース A" <<YAML
status: stable
refines:
  - "$SOL"
$gen
YAML
  item "$repo" uc-b "$UC_B" use_case "ユースケース B" <<YAML
status: stable
refines:
  - "$SOL"
$gen
YAML
  item "$repo" uc-dep "$UC_DEP" use_case "廃止したユースケース" <<YAML
status: deprecated
refines:
  - "$SOL"
$gen
YAML
  item "$repo" qa-sol "$QA_SOL" quality "solution の確認の問い" <<YAML
specification: "The fixture SHALL ask."
specification_ja: |
  solution の問いの 1 行目。
  solution の問いの 2 行目。
review_question_for: solution
status: stable
derives_from:
  - "$SOL"
$gen
YAML
  item "$repo" qa-uc "$QA_UC" quality "use_case の確認の問い" <<YAML
specification: "The fixture SHALL ask."
specification_ja: "use_case の問い。"
review_question_for: use_case
status: stable
derives_from:
  - "$SOL"
$gen
YAML
  item "$repo" req-1 "$REQ_1" requirement "要件 1" <<YAML
$req
status: stable
derives_from:
  - "$UC_A"
$gen
YAML
  item "$repo" req-2 "$REQ_2" requirement "確認済みの要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_A"
$gen
verified:
  - by: "human:someone"
    at: "2026-03-02T00:00:00+09:00"
YAML
  item "$repo" req-3 "$REQ_3" requirement "廃止した要件" <<YAML
$req
status: deprecated
derives_from:
  - "$UC_A"
$gen
YAML
  item "$repo" req-m "$REQ_M" requirement "2 つの親を持つ要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_A"
  - "$UC_B"
$gen
YAML
  item "$repo" req-4 "$REQ_4" requirement "古い人の確認を持つ要件" <<YAML
specification: |
  The fixture SHALL keep this requirement.
specification_ja: |
  fixture はこの要求を保たなければならない。
status: stable
derives_from:
  - "$UC_A"
$gen
verified:
  - by: "human:someone"
    at: "2026-02-01T00:00:00+09:00"
  - by: "claude-code/fixture"
    at: "2026-03-02T00:00:00+09:00"
section: product-scope
YAML
  item "$repo" dsg-0 "$DSG_0" design "設計 0" <<YAML
section: product-scope
status: stable
satisfies:
  - "$REQ_M"
$gen
YAML
  item "$repo" dsg-1 "$DSG_1" design "2 つの親を持つ設計" <<YAML
section: product-scope
status: stable
satisfies:
  - "$REQ_1"
  - "$REQ_M"
$gen
YAML
  git -C "$repo" init -q -b main
  git -C "$repo" config user.name fixture
  git -C "$repo" config user.email fixture@example.invalid
  git -C "$repo" add -A
  git -C "$repo" commit -q -m init
}

# 一時のリポジトリを作り直し、スタブのログとキューを空にする。キューは引数の各行。
n=0
fresh() {
  n=$((n + 1))
  repo="$work/repo-$n"
  make_repo "$repo"
  export STUB_QUEUE="$work/queue-$n" STUB_LEAF_LOG="$work/leaf-$n" STUB_EDITOR_LOG="$work/editor-$n"
  printf '%s\n' "$@" >"$STUB_QUEUE"
  : >"$STUB_LEAF_LOG"
  : >"$STUB_EDITOR_LOG"
  base=$(git -C "$repo" rev-parse HEAD)
}

# base より後のコミットの件名を古い順に、空白で区切って出す。
subjects() { git -C "$repo" log --reverse --format=%s "$base.." | tr '\n' ' ' | sed 's/ $//'; }

# 端末の判定を真にして sara-verify を実行し、stdout と exit code を取る。
run_verify() {
  out="$(cd "$repo" && env SARA_VERIFY_TTY=1 SARA_VERIFY_FZF="$work/bin/fzf" SARA_VERIFY_LEAF="$work/bin/leaf" \
    EDITOR="$work/bin/editor" SARA_VERIFY_HUMAN_ID="${human_id-tester}" "$@" sara-verify ${verify_args:+"$verify_args"} </dev/null 2>/dev/null)" &&
    status=0 || status=$?
}

decide='この item で決める'

# --- ヘルプ ---------------------------------------------------------------------

out="$(sara-verify --help 2>&1)" && status=0 || status=$?
assert_eq "--help は exit 0" 0 "$status"
assert_has "--help は使い方を出す" "usage: sara-verify" "$out"

# --- 対象の列挙と順序 -----------------------------------------------------------

# UC_A を選んで決める。経路の SOL・UC_A のあと、下流を幅優先と ID の順で、DSG_1 は 1 度だけ。
fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
run_verify
assert_eq "経路と下流を幅優先と ID の順で表示する（deprecated と確認済みを除く）" \
  "docs/sol.md docs/uc-a.md docs/req-1.md docs/req-m.md docs/req-4.md docs/dsg-0.md docs/dsg-1.md" \
  "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"
assert_eq "すべて飛ばすと exit 0" 0 "$status"
assert_eq "飛ばすと何も書かない" "" "$(git -C "$repo" status --porcelain)"

fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
verify_args=--all run_verify
assert_eq "--all は確認済みの item も対象にする" \
  "docs/sol.md docs/uc-a.md docs/req-1.md docs/req-2.md docs/req-m.md docs/req-4.md docs/dsg-0.md docs/dsg-1.md" \
  "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"

# 子の無い item まで降りると、そこで決まる。
fresh "$UC_B" "$REQ_M" "$DSG_0" 飛ばす 飛ばす 飛ばす 飛ばす
run_verify
assert_eq "子の無い item まで降りると、経路だけが対象になる" \
  "docs/sol.md docs/uc-b.md docs/req-m.md docs/dsg-0.md" "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"

# --- verified の書き込みと確認の問い ---------------------------------------------

fresh "$UC_A" "$REQ_4" 記録する 記録する 記録する
STUB_COMMENT=$'\n確かめた。\n# 除く行\n' run_verify
assert_eq "記録して終えると exit 0" 0 "$status"
assert_eq "verified の無い solution に 3 行を足す（削除なし）" $'3\t0' \
  "$(git -C "$repo" diff --numstat "$base" -- docs/sol.md | cut -f1,2)"
assert_eq "verified の無い use_case に 3 行を足す（削除なし）" $'3\t0' \
  "$(git -C "$repo" diff --numstat "$base" -- docs/uc-a.md | cut -f1,2)"
assert_eq "既存の verified の後ろに別のキーがあっても 2 行を足す（削除なし）" $'2\t0' \
  "$(git -C "$repo" diff --numstat "$base" -- docs/req-4.md | cut -f1,2)"
for f in sol uc-a req-4; do
  last="$(yq --front-matter=extract -o=json -I=0 '.verified[-1]' "$repo/docs/$f.md")"
  assert_eq "$f の最後の verified の by" '"human:tester"' "$(jq -c .by <<<"$last")"
  if jq -re .at <<<"$last" | grep -Eq '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}[+-][0-9]{2}:[0-9]{2}$'; then
    pass "$f の verified の at は UTC オフセット付きの ISO 8601"
  else
    fault "$f の verified の at の形（実際: $last）"
  fi
done
assert_eq "req-4 の既存の verified と後ろのキーを保つ" "3 product-scope" \
  "$(yq --front-matter=extract '(.verified | length) + " " + .section' "$repo/docs/req-4.md")"
assert_eq "generated は変えない" "2026-03-01T00:00:00+09:00" \
  "$(yq --front-matter=extract '.generated.at' "$repo/docs/sol.md")"
assert_has "solution の確認の問いを端末に出す" "solution の問いの 2 行目。" "$out"
assert_has "use_case の確認の問いを端末に出す" "use_case の問い。" "$out"
editor_log="$(<"$STUB_EDITOR_LOG")"
assert_has "solution の問いを # の行で EDITOR に載せる" "# solution の問いの 1 行目。" "$editor_log"
assert_has "solution の問いの 2 行目も # の行で載せる" "# solution の問いの 2 行目。" "$editor_log"
assert_has "use_case の問いを # の行で EDITOR に載せる" "# use_case の問い。" "$editor_log"
assert_lacks "requirement には問いを載せない" "# use_case の問い。" "$(sed -n '/^=== .*req-4/,$p' <<<"$editor_log")"
assert_eq "requirement では問いを端末に出さない（use_case の問いは 1 度だけ）" 1 "$(grep -c 'use_case の問い。' <<<"$out")"

# --- コミット -------------------------------------------------------------------

# 直前の記録のケースの続き: ファイルごとに 1 コミットにし、本文はコメントにする。
assert_eq "記録した item をファイルごとに、記録の順でコミットする" \
  "docs(solution): sol docs(use_case): uc-a docs(requirement): req-4" "$(subjects)"
assert_eq "本文は # の行と前後の空行を除いたコメント" "確かめた。" "$(git -C "$repo" log -1 --format=%b)"
assert_eq "コミットのあとに未コミットの変更を残さない" "" "$(git -C "$repo" status --porcelain)"
assert_eq "現在のブランチにコミットし、ブランチを作らない" "main" "$(git -C "$repo" branch --format='%(refname:short)')"

fresh "$UC_A" "$REQ_4" 記録する 飛ばす 飛ばす
STUB_COMMENT=$'\n# 除く行だけ\n' run_verify
assert_eq "コメントが空でも記録してコミットする" "docs(solution): sol" "$(subjects)"
assert_eq "コメントが空なら本文を書かない" "docs(solution): sol" "$(git -C "$repo" log -1 --format=%B | sed '/^$/d')"

fresh "$UC_A" "$REQ_4" 記録する 中断する
run_verify
assert_eq "「中断する」は exit 0" 0 "$status"
assert_eq "「中断する」でそこまでの記録をコミットする" "docs(solution): sol" "$(subjects)"
assert_eq "「中断する」で残りの item を表示しない" "docs/sol.md docs/uc-a.md" "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"
assert_eq "「中断する」のあとに未コミットの変更を残さない" "" "$(git -C "$repo" status --porcelain)"

fresh "$UC_A" "$REQ_4" 記録する __INT__
run_verify
assert_eq "fzf での Ctrl-C は exit 130" 130 "$status"
assert_eq "fzf での Ctrl-C でそこまでの記録をコミットする" "docs(solution): sol" "$(subjects)"

fresh "$UC_A" "$REQ_4" 記録する
STUB_LEAF_INT=docs/uc-a.md run_verify env --default-signal=INT
assert_eq "SIGINT は exit 130" 130 "$status"
assert_eq "SIGINT でそこまでの記録をコミットする" "docs(solution): sol" "$(subjects)"
assert_eq "SIGINT のあとに未コミットの変更を残さない" "" "$(git -C "$repo" status --porcelain)"

# --- 拒否 -----------------------------------------------------------------------

fresh "$UC_A" "$decide" 飛ばす
out="$(cd "$repo" && env -u SARA_VERIFY_TTY SARA_VERIFY_FZF="$work/bin/fzf" SARA_VERIFY_LEAF="$work/bin/leaf" \
  SARA_VERIFY_HUMAN_ID=tester sara-verify </dev/null 2>/dev/null)" && status=0 || status=$?
assert_eq "端末でないと exit 2" 2 "$status"
assert_eq "端末でないと何も表示しない" "" "$(<"$STUB_LEAF_LOG")"

for bad in '' $'a\nb' 'a"b' 'a\b'; do
  fresh "$UC_A" "$decide" 記録する
  human_id=$bad run_verify
  assert_eq "不正な <id>（$(printf '%q' "$bad")）は exit 2" 2 "$status"
  assert_eq "不正な <id>（$(printf '%q' "$bad")）では何も書かない" "" "$(git -C "$repo" status --porcelain)$(<"$STUB_LEAF_LOG")"
done
unset human_id

fresh "$UC_A" "$decide" 記録する
printf '\n追記。\n' >>"$repo/docs/req-1.md"
run_verify
assert_eq "対象のファイルに未コミットの変更があると exit 2" 2 "$status"
assert_eq "未コミットの変更があると何も表示しない" "" "$(<"$STUB_LEAF_LOG")"

fresh "$UC_B" "$REQ_M" "$DSG_0" 飛ばす 飛ばす 飛ばす 飛ばす
printf '\n追記。\n' >>"$repo/docs/req-1.md"
run_verify
assert_eq "対象でないファイルの未コミットの変更では拒否しない" 0 "$status"

fresh "$UC_A" "$decide" 記録する
printf -- '---\nid: "REQ-broken"\n---\n' >"$repo/docs/broken.md"
run_verify
assert_eq "sara check が失敗するグラフでは exit 2" 2 "$status"

exit "$fail"

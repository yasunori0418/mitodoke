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
# __INT__ は Ctrl-C（exit 130）。キューが尽きたら 98、候補に無ければ 99 で落ちる。受けた引数と候補は、別々のログへ写す。
cat >"$work/bin/fzf" <<'SH'
#!/usr/bin/env bash
printf '=== %s\n' "$*" >>"$STUB_FZF_LOG"
candidates=$(cat)
printf '===\n%s\n' "$candidates" >>"$STUB_CANDIDATES_LOG"
pattern=$(head -n 1 "$STUB_QUEUE")
[[ -s "$STUB_QUEUE" ]] || exit 98
sed -i 1d "$STUB_QUEUE"
[[ "$pattern" != __INT__ ]] || exit 130
grep -F -m 1 -- "$pattern" <<<"$candidates" || exit 99
SH
# leaf: 表示したファイルを記録する。STUB_LEAF_INT に一致するファイルでは呼び出し元へ SIGINT を送り、
# STUB_LEAF_FAIL に一致するファイルでは STUB_LEAF_RC（既定 127）で落ちる。
cat >"$work/bin/leaf" <<'SH'
#!/usr/bin/env bash
printf '%s\n' "$1" >>"$STUB_LEAF_LOG"
if [[ -n "${STUB_LEAF_INT-}" && "$1" == "$STUB_LEAF_INT" ]]; then kill -INT "$PPID"; fi
if [[ -n "${STUB_LEAF_FAIL-}" && "$1" == "$STUB_LEAF_FAIL" ]]; then exit "${STUB_LEAF_RC:-127}"; fi
SH
# EDITOR: 初期の文面をログへ写し、STUB_COMMENT を書き足す（# の行は残したまま）。
# STUB_COMMENT の %s は、初期の文面の 1 行目にある item のパスに置き換える。
cat >"$work/bin/editor" <<'SH'
#!/usr/bin/env bash
{ printf '=== %s\n' "$1"; cat "$1"; } >>"$STUB_EDITOR_LOG"
item=$(head -n 1 "$1" | cut -d ' ' -f 2)
# shellcheck disable=SC2059
printf "${STUB_COMMENT-}" "$item" >>"$1"
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
REQ_EQ="REQ-aaaa0006-0000-4000-8000-000000000006"
REQ_TZ="REQ-aaaa0007-0000-4000-8000-000000000007"
RISK_X="RISK-11110001-0000-4000-8000-000000000001"
UC_V="UC-0ca11004-0000-4000-8000-000000000004"
REQ_V="REQ-aaaa0008-0000-4000-8000-000000000008"
UC_DONE="UC-0ca11005-0000-4000-8000-000000000005"
REQ_DONE="REQ-aaaa0009-0000-4000-8000-000000000009"
REQ_UNDER_DEP="REQ-aaaa000a-0000-4000-8000-00000000000a"
ADR_1="ADR-ad000002-0000-4000-8000-000000000002"
ADR_2="ADR-ad000001-0000-4000-8000-000000000001"
ADR_V="ADR-ad000003-0000-4000-8000-000000000003"
ADR_DEP="ADR-ad000004-0000-4000-8000-000000000004"
UBQ_1="UBQ-0b000002-0000-4000-8000-000000000002"
UBQ_2="UBQ-0b000001-0000-4000-8000-000000000001"

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

# 経路と下流（REQ_1・REQ_M から届く DSG_1、深さ 1 の REQ_1 と深さ 2 の DSG_1 から届く RISK_X）、
# ID の順（DSG_0 < DSG_1 < RISK_X）、deprecated（UC_DEP・REQ_3）、確認済み（REQ_2、generated.at と同じ瞬間を
# Z で書いた REQ_EQ）、generated.at より前の時差付きの確認（REQ_TZ）、verified の後ろに別のキーが続く item（REQ_4）を
# 1 つのグラフに置く。枝を選ぶ候補のために、確認済みで下に未確認の要件を持つ UC_V（REQ_V）、下まで確認済みの
# UC_DONE（REQ_DONE）、deprecated の UC_DEP だけを親に持つ REQ_UNDER_DEP も置く。
# solution から辿れない型として、adr（未確認の ADR_1・ADR_2、確認済みの ADR_V、deprecated の ADR_DEP）と
# ubiquitous_term（UBQ_1・UBQ_2）を置く。ID の順とファイル名の順を逆にして、一覧がファイル名の順であることを見る。
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
  human_verified='verified:
  - by: "human:someone"
    at: "2026-03-02T00:00:00+09:00"'
  item "$repo" uc-v "$UC_V" use_case "確認済みで下に未確認を持つユースケース" <<YAML
status: stable
refines:
  - "$SOL"
$gen
$human_verified
YAML
  item "$repo" req-v "$REQ_V" requirement "確認済みのユースケースの下の未確認の要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_V"
$gen
YAML
  item "$repo" uc-done "$UC_DONE" use_case "下まで確認済みのユースケース" <<YAML
status: stable
refines:
  - "$SOL"
$gen
$human_verified
YAML
  item "$repo" req-done "$REQ_DONE" requirement "下まで確認済みのユースケースの要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_DONE"
$gen
$human_verified
YAML
  item "$repo" req-under-dep "$REQ_UNDER_DEP" requirement "廃止したユースケースだけを親に持つ要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_DEP"
$gen
YAML
  adr='section: graph-model
origin: "fixture"
justifies:
  - "'"$REQ_1"'"'
  item "$repo" adr-1 "$ADR_1" adr "決定 1" <<YAML
$adr
status: stable
$gen
YAML
  item "$repo" adr-2 "$ADR_2" adr "決定 2" <<YAML
$adr
status: stable
$gen
YAML
  item "$repo" adr-v "$ADR_V" adr "確認済みの決定" <<YAML
$adr
status: stable
$gen
$human_verified
YAML
  item "$repo" adr-dep "$ADR_DEP" adr "廃止した決定" <<YAML
$adr
status: deprecated
$gen
YAML
  item "$repo" ubq-1 "$UBQ_1" ubiquitous_term "用語 1" <<YAML
section: model-types
status: stable
$gen
YAML
  item "$repo" ubq-2 "$UBQ_2" ubiquitous_term "用語 2" <<YAML
section: model-types
status: stable
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
  item "$repo" req-eq "$REQ_EQ" requirement "生成と同じ瞬間に人が確認した要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_A"
$gen
verified:
  - by: "human:someone"
    at: "2026-02-28T15:00:00Z"
YAML
  item "$repo" req-tz "$REQ_TZ" requirement "生成より前に時差付きで人が確認した要件" <<YAML
$req
status: stable
derives_from:
  - "$UC_A"
$gen
verified:
  - by: "human:someone"
    at: "2026-03-01T00:00:00+10:00"
YAML
  item "$repo" risk-x "$RISK_X" risk "深さの違う 2 つの親を持つリスク" <<YAML
section: engine-core
status: stable
threatens:
  - "$REQ_1"
  - "$DSG_1"
likelihood: low
impact: low
level: low
quality_characteristic: reliability
$gen
YAML
  git -C "$repo" init -q -b main
  git -C "$repo" config user.name fixture
  git -C "$repo" config user.email fixture@example.invalid
  git -C "$repo" add -A
  git -C "$repo" commit -q -m init
}

# 一時のリポジトリを作り直し、スタブのログとキューを空にする。キューは、起点の型（start。既定は solution）を
# 選ぶ行と、引数の各行。
n=0
fresh() {
  n=$((n + 1))
  repo="$work/repo-$n"
  make_repo "$repo"
  export STUB_QUEUE="$work/queue-$n" STUB_LEAF_LOG="$work/leaf-$n" STUB_EDITOR_LOG="$work/editor-$n" STUB_FZF_LOG="$work/fzf-$n"
  export STUB_CANDIDATES_LOG="$work/candidates-$n"
  printf '%s\n' "${start-solution から}" "$@" >"$STUB_QUEUE"
  : >"$STUB_LEAF_LOG"
  : >"$STUB_EDITOR_LOG"
  : >"$STUB_FZF_LOG"
  : >"$STUB_CANDIDATES_LOG"
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

# UC_A を選んで決める。経路の SOL・UC_A のあと、下流を幅優先と ID の順で、DSG_1 と RISK_X は 1 度だけ。
fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
run_verify
assert_eq "経路と下流を幅優先と ID の順で表示する（deprecated と確認済みを除く）" \
  "docs/sol.md docs/uc-a.md docs/req-1.md docs/req-m.md docs/req-4.md docs/req-tz.md docs/dsg-0.md docs/dsg-1.md docs/risk-x.md" \
  "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"
assert_eq "すべて飛ばすと exit 0" 0 "$status"
assert_eq "飛ばすと何も書かない" "" "$(git -C "$repo" status --porcelain)"

fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
verify_args=--all run_verify
assert_eq "--all は確認済みの item も対象にする" \
  "docs/sol.md docs/uc-a.md docs/req-1.md docs/req-2.md docs/req-m.md docs/req-4.md docs/req-eq.md docs/req-tz.md docs/dsg-0.md docs/dsg-1.md docs/risk-x.md" \
  "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"

# 子の無い item まで降りると、そこで決まる。
fresh "$UC_B" "$REQ_M" "$DSG_0" 飛ばす 飛ばす 飛ばす 飛ばす
run_verify
assert_eq "子の無い item まで降りると、経路だけが対象になる" \
  "docs/sol.md docs/uc-b.md docs/req-m.md docs/dsg-0.md" "$(tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//')"

# --- 枝を選ぶ候補 ---------------------------------------------------------------

# 候補のログから、枝を選ぶ画面の何番目か（1 始まり）の候補を出す。
candidates_of() { awk -v n="$1" '$0 == "===" { i++; next } i == n' "$STUB_CANDIDATES_LOG"; }

fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
run_verify
first="$(candidates_of 2)"
second="$(candidates_of 3)"
assert_lacks "deprecated の item は枝を選ぶ候補に出ない" "$UC_DEP" "$first"
assert_lacks "下まで確認済みの枝は候補に出ない" "$UC_DONE" "$first"
assert_has "確認済みでも、下に未確認の item があれば候補に出る" "$UC_V" "$first"
assert_eq "候補の確認済みの item には印が付く" "確認済み" "$(grep -F -- "$UC_V" <<<"$first" | cut -f5)"
assert_eq "未確認の item には印が付かない" "" "$(grep -F -- "$UC_A" <<<"$first" | cut -f5)"
assert_lacks "2 段目でも deprecated の item は候補に出ない" "$REQ_3" "$second"
assert_lacks "2 段目でも、下に未確認の item が無い確認済みの item は候補に出ない" "$REQ_2" "$second"
assert_has "2 段目に未確認の item は出る" "$REQ_1" "$second"

fresh "$UC_A" "$decide" 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす 飛ばす
verify_args=--all run_verify
assert_has "--all は下まで確認済みの枝も候補に出す" "$UC_DONE" "$(candidates_of 2)"
assert_has "--all は確認済みの item も候補に出す" "$REQ_2" "$(candidates_of 3)"
assert_lacks "--all でも deprecated の item は候補に出ない" "$UC_DEP" "$(candidates_of 2)"

# 根で決めると、下流のすべてが対象になる。deprecated の item を経由してしか届かない item は対象にしない。
# shellcheck disable=SC2046
fresh "$decide" $(printf '飛ばす %.0s' $(seq 1 30))
run_verify
leaf_log="$(<"$STUB_LEAF_LOG")"
assert_lacks "deprecated の item を経由してしか届かない item は対象にしない" "docs/req-under-dep.md" "$leaf_log"
assert_has "確認済みの item の下の未確認の item は対象にする" "docs/req-v.md" "$leaf_log"
assert_lacks "確認済みの item は対象にしない" "docs/uc-v.md" "$leaf_log"

# --- 起点の型 -------------------------------------------------------------------

all_items='すべてを順に確認する'
leaf_shown() { tr '\n' ' ' <"$STUB_LEAF_LOG" | sed 's/ $//'; }

fresh "$UC_A" "$decide" 中断する
run_verify
assert_eq "起動すると、solution・adr・ubiquitous_term のどこから確認するかを選ぶ" "solution adr ubiquitous_term" \
  "$(candidates_of 1 | cut -f1 | tr '\n' ' ' | sed 's/ $//')"

# adr は solution から辿れないので、一覧から選ぶ。ファイル名の順に並べ、deprecated と確認済みを除く。
start='ADR を' fresh "$all_items" 飛ばす 飛ばす
run_verify
assert_eq "adr はすべてを選ぶと、ファイル名の順に表示する（deprecated と確認済みを除く）" \
  "docs/adr-1.md docs/adr-2.md" "$(leaf_shown)"
assert_eq "adr をすべて飛ばすと exit 0" 0 "$status"
list="$(candidates_of 2)"
assert_lacks "deprecated の adr は一覧に出ない" "$ADR_DEP" "$list"
assert_lacks "確認済みの adr は一覧に出ない" "$ADR_V" "$list"
assert_lacks "adr の一覧にほかの型は出ない" "$UC_A" "$list"

start='ADR を' fresh "$all_items" 飛ばす 飛ばす 飛ばす
verify_args=--all run_verify
assert_eq "--all は確認済みの adr も対象にする" "docs/adr-1.md docs/adr-2.md docs/adr-v.md" "$(leaf_shown)"
assert_eq "--all の一覧の確認済みの adr には印が付く" "確認済み" "$(candidates_of 2 | grep -F -- "$ADR_V" | cut -f5)"
assert_lacks "--all でも deprecated の adr は一覧に出ない" "$ADR_DEP" "$(candidates_of 2)"

start='ADR を' fresh "$ADR_2" 記録する
run_verify
assert_eq "adr を 1 本選ぶと、その 1 本だけが対象になる" "docs/adr-2.md" "$(leaf_shown)"
assert_eq "adr の記録は docs(adr): <slug> でコミットする" "docs(adr): adr-2" "$(subjects)"
assert_eq "adr の verified に要素を足す" 'human:tester' \
  "$(yq --front-matter=extract '.verified[-1].by' "$repo/docs/adr-2.md")"
assert_eq "adr のコミットのあとに未コミットの変更を残さない" "" "$(git -C "$repo" status --porcelain)"

start='用語を' fresh "$all_items" 記録する 飛ばす
run_verify
assert_eq "ubiquitous_term はすべてを選ぶと、ファイル名の順に表示する" "docs/ubq-1.md docs/ubq-2.md" "$(leaf_shown)"
assert_eq "ubiquitous_term の記録は docs(ubiquitous_term): <slug> でコミットする" "docs(ubiquitous_term): ubq-1" "$(subjects)"
assert_lacks "ubiquitous_term の一覧に adr は出ない" "$ADR_1" "$(candidates_of 2)"

# --- verified の書き込みと確認の問い ---------------------------------------------

fresh "$UC_A" "$REQ_4" 記録する 記録する 記録する
STUB_COMMENT=$'\n%s を確かめた。\n# 除く行\n' run_verify
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
assert_lacks "requirement には問いを載せない" "# use_case の問い。" "$(sed -n '/^# docs\/req-4.md /,$p' <<<"$editor_log")"
fzf_log="$(<"$STUB_FZF_LOG")"
assert_eq "記録するかを選ぶ画面は、端末に出した問いを隠さないよう画面の一部に出す" 3 \
  "$(grep -c -- '--height=~50% --header .* docs/' <<<"$fzf_log")"
assert_eq "「記録する」を選んだ item の数だけ EDITOR を開く" 3 "$(grep -c '^=== ' <<<"$editor_log")"

assert_eq "requirement では問いを端末に出さない（use_case の問いは 1 度だけ）" 1 "$(grep -c 'use_case の問い。' <<<"$out")"

# --- コミット -------------------------------------------------------------------

# 直前の記録のケースの続き: ファイルごとに 1 コミットにし、本文はコメントにする。
assert_eq "記録した item をファイルごとに、記録の順でコミットする" \
  "docs(solution): sol docs(use_case): uc-a docs(requirement): req-4" "$(subjects)"
bodies=''
for c in $(git -C "$repo" rev-list --reverse "$base.."); do bodies+="$(git -C "$repo" log -1 --format=%b "$c")|"; done
assert_eq "本文はその item のコメントで、# の行と前後の空行を除く" \
  "docs/sol.md を確かめた。|docs/uc-a.md を確かめた。|docs/req-4.md を確かめた。|" "$bodies"
assert_eq "コミットのあとに未コミットの変更を残さない" "" "$(git -C "$repo" status --porcelain)"
assert_eq "現在のブランチにコミットし、ブランチを作らない" "main" "$(git -C "$repo" branch --format='%(refname:short)')"

# verified が frontmatter の最後のキーの item に足す。
fresh "$UC_A" "$REQ_2" 飛ばす 飛ばす 記録する
verify_args=--all run_verify
assert_eq "verified が最後のキーでも 2 行を足す（削除なし）" $'2\t0' \
  "$(git -C "$repo" diff --numstat "$base" -- docs/req-2.md | cut -f1,2)"
assert_eq "最後のキーの verified に要素を足す" '2 human:tester' \
  "$(yq --front-matter=extract '(.verified | length) + " " + .verified[-1].by' "$repo/docs/req-2.md")"

fresh "$UC_A" "$REQ_4" 記録する 飛ばす 飛ばす
STUB_COMMENT=$'\n# 除く行だけ\n' run_verify
assert_eq "コメントが空でも記録してコミットする" "docs(solution): sol" "$(subjects)"
assert_eq "コメントが空なら本文を書かない" "docs(solution): sol" "$(git -C "$repo" log -1 --format=%B | sed '/^$/d')"
assert_eq "「飛ばす」では EDITOR を開かない" 1 "$(grep -c '^=== ' <"$STUB_EDITOR_LOG")"

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

fresh "$UC_A" "$REQ_4" 記録する
STUB_LEAF_FAIL=docs/uc-a.md run_verify
assert_eq "leaf の失敗は exit 2" 2 "$status"
assert_eq "途中で失敗しても、そこまでの記録をコミットする" "docs(solution): sol" "$(subjects)"

fresh "$UC_A" "$REQ_4" 記録する
STUB_LEAF_FAIL=docs/uc-a.md STUB_LEAF_RC=130 run_verify
assert_eq "leaf の exit 130 は中断として exit 130" 130 "$status"
assert_eq "leaf の exit 130 でそこまでの記録をコミットする" "docs(solution): sol" "$(subjects)"

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
assert_eq "sara check が失敗するグラフでは何も表示せず、コミットしない" "" "$(<"$STUB_LEAF_LOG")$(subjects)"

exit "$fail"

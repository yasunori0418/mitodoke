#!/usr/bin/env bash
# sara-gap（グラフの未カバーと到達率を 12 節で出すコマンド）の検証。fixture に実物の docs/model.yaml を重ねる。
#
# 実行:
#   nix develop ./dev -c dev/tests/sara-gap.sh   # devShell から直接
#   nix flake check ./dev                         # checks.sara-gap 経由
set -uo pipefail

fail=0
pass() { printf 'ok   - %s\n' "$1"; }
fault() {
  printf 'FAIL - %s\n' "$1"
  fail=1
}

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# fixture はスクリプト自身からの相対で解決する。
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fixture="$script_dir/fixtures/sara-gap"

if [[ ! -d "$fixture/docs" ]]; then
  fault "fixture を解決できない（$fixture）"
  exit 1
fi

# モデルは実リポジトリの docs/model.yaml。SARA_GAP_MODEL_YAML があればそれを、無ければ git ルート基準で引く。
# どちらでも解決できなければ失敗させる。
model_yaml="${SARA_GAP_MODEL_YAML:-}"
contract_root="$(git rev-parse --show-toplevel 2>/dev/null || printf '.')"
[[ -f "$model_yaml" ]] || model_yaml="$contract_root/docs/model.yaml"
if [[ ! -f "$model_yaml" ]]; then
  fault "docs/model.yaml を解決できない（model.yaml=$model_yaml）"
  exit 1
fi

# fixture の複製に実物モデルを重ねて、実行可能な sara リポジトリの形を作る。
make_fixture() {
  mkdir -p "$1"
  cp -r "$fixture"/. "$1"
  cp "$model_yaml" "$1/model.yaml"
}

# 対象外の品質特性の TSV を <パス> に書く。1 行目はヘッダで、残りの引数の特性を 1 行ずつ理由付きで並べる。
write_exclusions() {
  local path=$1
  shift
  mkdir -p "$(dirname "$path")"
  {
    printf 'quality_characteristic\treason\n'
    [[ "$#" -eq 0 ]] || printf '%s\tfixture では扱わない\n' "$@"
  } >"$path"
}

all_characteristics=(functional_suitability performance_efficiency compatibility interaction_capability reliability security maintainability flexibility safety)
excl_all="$work/exclusions-all.tsv"
write_exclusions "$excl_all" "${all_characteristics[@]}"
# fixture の risk はどれも reliability なので、残りの 8 特性が risk を持たない。
unrisked_characteristics=(functional_suitability performance_efficiency compatibility interaction_capability security maintainability flexibility safety)

base="$work/base"
make_fixture "$base"

# base の期待値は unthreatened 2・unmitigated 2・uncovered 1・unfollowed 1・unsatisfied_quality 1・exempt 1・exempt_quality 1。
# 鎖が最後までつながる要求は REQ-aaaa0001 だけで、DSG-dd000001 は risk の有無によらず列挙しない。

run_gap() {
  stdout_capture="$("$@" 2>/dev/null)" && status_capture=0 || status_capture=$?
}

# 値が一致すれば pass、違えば実際の値つきで fault にする。
assert_eq() {
  if [[ "$2" == "$3" ]]; then
    pass "$1"
  else
    fault "$1（期待: $2 実際: $3）"
  fi
}

# 文字列 $3 に正規表現 $2 が一致するかを確かめる。
assert_has() {
  if grep -Eq -- "$2" <<<"$3"; then
    pass "$1"
  else
    fault "$1（$2 が出力に無い）"
  fi
}

assert_lacks() {
  if ! grep -Eq -- "$2" <<<"$3"; then
    pass "$1"
  else
    fault "$1（$2 が出力に出ている）"
  fi
}

# text 出力 $2 から見出し $1 の節の本文だけを取り出す。
section_body() {
  local line inside=0
  while IFS= read -r line; do
    if [[ "$line" == "## "* ]]; then
      if [[ "$line" == "$1" ]]; then inside=1; else inside=0; fi
      continue
    fi
    if [[ "$inside" -eq 1 ]]; then printf '%s\n' "$line"; fi
  done <<<"$2"
}

h_unthreatened='## threatens も risk_exempt も無い requirement'
h_unmitigated='## mitigates されていない risk'
h_uncovered='## covers されていない test_condition'
h_unfollowed='## follows を持たない test_case'
h_unsatisfied='## infrastructure に satisfies されていない quality'
h_exempt='## risk_exempt を持つ requirement（情報）'
h_reach='## 到達率'
h_uc_noreq='## 有効な requirement を持たない use_case'
h_req_depuc='## 親の use_case がすべて deprecated の requirement'
h_qc='## 有効な risk を持たない品質特性'
h_hj='## human_judgement を持つ test_condition（情報）'
h_exq='## infrastructure_exempt を持つ quality（情報）'
expected_headings="$(printf '%s\n' "$h_unthreatened" "$h_unmitigated" "$h_uncovered" "$h_unfollowed" "$h_unsatisfied" "$h_exempt" "$h_reach" \
  "$h_uc_noreq" "$h_req_depuc" "$h_qc" "$h_hj" "$h_exq")"
design_mark='\(design 側に risk あり\)$'
full_id='^[A-Z]+-[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'$'\t'
short_id='^[A-Z]+-[0-9a-f]{8}'$'\t'

# --- 1. 12 節の検出と exit 1 ---------------------------------------------------

run_gap env SARA_GAP_ROOT="$base" sara-gap
gap_out="$stdout_capture"

assert_eq "ギャップがあれば exit 1" 1 "$status_capture"
assert_eq "見出しを 12 個、この順に出す" "$expected_headings" "$(grep '^## ' <<<"$gap_out")"

sec_unthreatened="$(section_body "$h_unthreatened" "$gap_out")"
sec_unfollowed="$(section_body "$h_unfollowed" "$gap_out")"
sec_exempt="$(section_body "$h_exempt" "$gap_out")"

assert_has "risk の無い REQ を節 1 に出す" '^REQ-bbbb0002' "$sec_unthreatened"
assert_has "mitigates されていない RISK を節 2 に出す" '^RISK-22220002' "$(section_body "$h_unmitigated" "$gap_out")"
assert_has "covers されていない TC を節 3 に出す" '^TC-44440002' "$(section_body "$h_uncovered" "$gap_out")"
assert_has "follows の無い CASE を節 4 に出す" '^CASE-55550001' "$sec_unfollowed"
assert_has "INF に satisfies されない QA を節 5 に出す" '^QA-88880002' "$(section_body "$h_unsatisfied" "$gap_out")"

for nowant in REQ-aaaa0001 RISK-11110001 TC-33330001 CASE-66660002 QA-88880001; do
  assert_lacks "張り先を持つ $nowant を列挙しない" "^$nowant" "$gap_out"
done

assert_lacks "design を列挙しない" 'DSG-dd000001' "$gap_out"
assert_lacks "risk_exempt を持つ REQ を節 1 に出さない" 'REQ-cccc0003' "$sec_unthreatened"
assert_has "risk_exempt を持つ REQ を節 6 に出す" '^REQ-cccc0003' "$sec_exempt"
assert_lacks "infrastructure_exempt を持つ QA を節 5 に出さない" 'QA-88880003' "$(section_body "$h_unsatisfied" "$gap_out")"
assert_eq "有効で infrastructure_exempt を持つ QA だけを節 12 に出す" \
  "QA-88880003-0000-4000-8000-000000000033"$'\t'"infrastructure の支えを免除した品質方針"$'\t'"docs/qa-exempt.md" \
  "$(section_body "$h_exq" "$gap_out" | grep -v '^$')"
assert_has "design 側にだけ risk がある REQ に印を付ける" "^REQ-dddd0004.*$design_mark" "$sec_unthreatened"
assert_lacks "design 側に risk が無い REQ には印を付けない" "^REQ-bbbb0002.*$design_mark" "$sec_unthreatened"

# --- 2. text の行形式 ----------------------------------------------------------

req_line="$(grep '^REQ-bbbb0002' <<<"$gap_out")"
assert_eq "行が <フル ID>\\t<name>\\t<docs/ 前置の file> の形" \
  $'REQ-bbbb0002-0000-4000-8000-000000000004\trisk が無い要求\tdocs/req-gap.md' "$req_line"

# 節 7 の前までの行だけを見る。節 7 の行は ID を持たない。
item_lines="$(grep -Ev '^(## .*|なし|)$' <<<"${gap_out%%"$h_reach"*}")"
assert_eq "節 1〜6 の行は 8 件" 8 "$(grep -c '' <<<"$item_lines")"
assert_eq "節 1〜6 の行の先頭がすべてフル ID" 8 "$(grep -Ec "$full_id" <<<"$item_lines")"
assert_eq "8 文字省略形を出さない" 0 "$(grep -Ec "$short_id" <<<"$gap_out")"

sec_reach="$(section_body "$h_reach" "$gap_out")"
assert_has "節 7 に requirement の到達率を出す" $'^requirement\t1/3\t33\\.3%$' "$sec_reach"
assert_has "節 7 に test_plan の到達率を出す" $'^test_plan\t1/1\t100%$' "$sec_reach"
assert_has "節 7 に quality の到達率を出す" $'^quality\t1/2\t50%$' "$sec_reach"

# --- 3. --json -----------------------------------------------------------------

run_gap env SARA_GAP_ROOT="$base" sara-gap --json
json_out="$stdout_capture"

assert_eq "--json でも exit code は同じ（ギャップあり = 1）" 1 "$status_capture"
assert_eq "--json は 12 キーのオブジェクトを返す" \
  "exempt,exempt_quality,human_judgement,quality_characteristic_without_risk,reach,requirement_under_deprecated_use_case,uncovered,unfollowed,unmitigated,unsatisfied_quality,unthreatened,use_case_without_requirement" \
  "$(jq -r 'keys | join(",")' <<<"$json_out" 2>/dev/null)"
assert_eq "--json の件数が 2,2,1,1,1,1" "2,2,1,1,1,1" \
  "$(jq -r '[.unthreatened, .unmitigated, .uncovered, .unfollowed, .unsatisfied_quality, .exempt | length] | join(",")' <<<"$json_out" 2>/dev/null)"
assert_eq "--json の行のキーは id / name / file だけ" '["file,id,name"]' \
  "$(jq -c '[.unthreatened, .unmitigated, .uncovered, .unfollowed, .unsatisfied_quality, .exempt | .[] | keys | join(",")] | unique' <<<"$json_out" 2>/dev/null)"
assert_eq "--json の行の id はフル ID で file は docs/ 前置" "true" \
  "$(jq -r '.unsatisfied_quality[0] | (.id == "QA-88880002-0000-4000-8000-000000000010") and (.name != "") and (.file | startswith("docs/"))' <<<"$json_out" 2>/dev/null)"
assert_eq "exempt に risk_exempt を持つ REQ が入る" "REQ-cccc0003-0000-4000-8000-00000000000b" \
  "$(jq -r '.exempt[0].id' <<<"$json_out" 2>/dev/null)"
assert_eq "exempt_quality の行は id / name / file" '[{"file":"docs/qa-exempt.md","id":"QA-88880003-0000-4000-8000-000000000033","name":"infrastructure の支えを免除した品質方針"}]' \
  "$(jq -c '[.exempt_quality[] | to_entries | sort_by(.key) | from_entries]' <<<"$json_out" 2>/dev/null)"
assert_eq "unfollowed に follows の無い CASE だけが入る" "CASE-55550001-0000-4000-8000-00000000000a" \
  "$(jq -r '[.unfollowed[].id] | join(",")' <<<"$json_out" 2>/dev/null)"
assert_eq "reach の 3 値が期待どおり" "true" \
  "$(jq '.reach == {requirement: {total: 3, reached: 1, ratio: (1 / 3)}, test_plan: {total: 1, reached: 1, ratio: 1}, quality: {total: 2, reached: 1, ratio: 0.5}}' <<<"$json_out" 2>/dev/null)"

# --- 4. ギャップを埋めた派生 fixture ------------------------------------------
#
# 免除の REQ と risk の無い DSG-dd000001 は残し、どちらも exit に効かないことを確かめる。
# risk の持つ reliability 以外の品質特性は、既定のパスの TSV で対象外にする。

fill_gaps() {
  make_fixture "$1"
  write_exclusions "$1/dev/tests/quality-characteristic-exclusions.tsv" "${unrisked_characteristics[@]}"
  rm "$1"/docs/{req-gap,risk-gap,tc-gap,qa-gap,req-design-only,risk-on-design}.md
  sed -i '/REQ-dddd0004/d' "$1/docs/dsg-gap.md"
  sed -i 's|^covers:$|follows:\n  - "TP-77770001-0000-4000-8000-00000000000e"\ncovers:|' "$1/docs/case.md"
}

clean="$work/clean"
fill_gaps "$clean"

run_gap env SARA_GAP_ROOT="$clean" sara-gap
clean_out="$stdout_capture"
assert_eq "ギャップが無ければ exit 0（exempt と exempt_quality は exit に影響しない）" 0 "$status_capture"
assert_eq "見出しは埋めても 12 個" 12 "$(grep -c '^## ' <<<"$clean_out")"
assert_eq "0 件の節 1〜5 と新しい節は「なし」と出す" 9 "$(grep -c '^なし$' <<<"$clean_out")"
assert_has "exempt は埋めても節 6 に出る" '^REQ-cccc0003' "$(section_body "$h_exempt" "$clean_out")"
assert_has "exempt_quality は埋めても節 12 に出る" '^QA-88880003' "$(section_body "$h_exq" "$clean_out")"
assert_lacks "risk の無い design を列挙しない" 'DSG-dd000001' "$clean_out"

run_gap env SARA_GAP_ROOT="$clean" sara-gap --json
assert_eq "--json でもギャップ 5 配列が空で exit 0" "0:0" \
  "$status_capture:$(jq -r '[.unthreatened, .unmitigated, .uncovered, .unfollowed, .unsatisfied_quality | length] | add' <<<"$stdout_capture" 2>/dev/null)"
assert_eq "--json の reach がすべて 1" "1,1,1" \
  "$(jq -r '[.reach.requirement, .reach.test_plan, .reach.quality | .ratio] | join(",")' <<<"$stdout_capture" 2>/dev/null)"

# 節 1〜5 が空でも、follows されない TP があれば到達率だけで exit 1 になる。
reach_only="$work/reach-only"
fill_gaps "$reach_only"
cat >"$reach_only/docs/tp-unfollowed.md" <<'MD'
---
id: "TP-77770002-0000-4000-8000-000000000013"
type: test_plan
name: "follows されないテスト計画"
status: stable
derives_from:
  - "SOL-5011a001-0000-4000-8000-000000000001"
specification: |
  The test process SHALL leave this test plan unfollowed.
specification_ja: |
  テストプロセスはこのテスト計画を follows されない状態に保たなければならない。
---
# TP-77770002: follows されないテスト計画
MD

run_gap env SARA_GAP_ROOT="$reach_only" sara-gap
reach_only_out="$stdout_capture"
assert_eq "到達率だけが 1 未満でも exit 1" 1 "$status_capture"
assert_eq "到達率だけが 1 未満のとき節 1〜5 と新しい節は空" 9 "$(grep -c '^なし$' <<<"$reach_only_out")"

# 到達率がすべて 1 のまま節 2〜4 のどれか 1 件だけが残っても exit 1 になる。
for gap_file in risk-gap tc-gap case; do
  single="$work/single-$gap_file"
  fill_gaps "$single"
  cp "$fixture/docs/$gap_file.md" "$single/docs/$gap_file.md"
  run_gap env SARA_GAP_ROOT="$single" sara-gap --json
  assert_eq "$gap_file.md のギャップだけで exit 1（到達率はすべて 1）" "1:1,1,1" \
    "$status_capture:$(jq -r '[.reach.requirement, .reach.test_plan, .reach.quality | .ratio] | join(",")' <<<"$stdout_capture" 2>/dev/null)"
done

# design があっても risk に threatens されていなければ印を付けない。
no_design_risk="$work/no-design-risk"
make_fixture "$no_design_risk"
rm "$no_design_risk/docs/risk-on-design.md"

run_gap env SARA_GAP_ROOT="$no_design_risk" sara-gap
assert_has "risk の無い design しか持たない REQ を節 1 に出す" '^REQ-dddd0004' "$stdout_capture"
assert_lacks "risk の無い design しか持たない REQ には印を付けない" "^REQ-dddd0004.*$design_mark" "$stdout_capture"

# 値が空の risk_exempt は免除にならない。
empty_exempt="$work/empty-exempt"
make_fixture "$empty_exempt"
sed -i 's/^risk_exempt: .*/risk_exempt: ""/' "$empty_exempt/docs/req-exempt.md"

run_gap env SARA_GAP_ROOT="$empty_exempt" sara-gap --json
assert_eq "空の risk_exempt を持つ REQ は exempt に出ず unthreatened に出る" "0:true" \
  "$(jq -r '"\(.exempt | length):\([.unthreatened[].id] | any(startswith("REQ-cccc0003")))"' <<<"$stdout_capture" 2>/dev/null)"
assert_eq "空の risk_exempt を持つ REQ は到達率の total に入る" "4" \
  "$(jq -r '.reach.requirement.total' <<<"$stdout_capture" 2>/dev/null)"

# 値が空の infrastructure_exempt も免除にならない。
empty_inf_exempt="$work/empty-inf-exempt"
make_fixture "$empty_inf_exempt"
sed -i 's/^infrastructure_exempt: .*/infrastructure_exempt: ""/' "$empty_inf_exempt/docs/qa-exempt.md"
run_gap env SARA_GAP_ROOT="$empty_inf_exempt" sara-gap --json
assert_eq "空の infrastructure_exempt を持つ QA は exempt_quality に出ず unsatisfied_quality と到達率の total に入る" "0:true:3" \
  "$(jq -r '"\(.exempt_quality | length):\([.unsatisfied_quality[].id] | any(startswith("QA-88880003"))):\(.reach.quality.total)"' <<<"$stdout_capture" 2>/dev/null)"

# CASE が無くなると TC までつながっていても requirement は到達にならない。
no_case="$work/no-case"
fill_gaps "$no_case"
rm "$no_case/docs/case.md" "$no_case/docs/case-followed.md"

run_gap env SARA_GAP_ROOT="$no_case" sara-gap --json
assert_eq "鎖が CASE まで届かない REQ は reached に数えない" "true" \
  "$(jq '.reach.requirement == {total: 1, reached: 0, ratio: 0}' <<<"$stdout_capture" 2>/dev/null)"

# --- 4b. use_case と requirement の、deprecated を考えたつながり --------------
#
# 有効な requirement の無い use_case と、親の use_case がすべて deprecated の requirement を確かめる。

SOL_ID="SOL-5011a001-0000-4000-8000-000000000001"
UC_ID="UC-0ca11001-0000-4000-8000-000000000002"
UC_DEPREQ="UC-0ca11002-0000-4000-8000-000000000020"
UC_DEP="UC-0ca11003-0000-4000-8000-000000000021"
UC_DRAFT="UC-0ca11004-0000-4000-8000-000000000022"
UC_DEP_EMPTY="UC-0ca11005-0000-4000-8000-000000000028"
REQ_DEP="REQ-eeee0001-0000-4000-8000-000000000023"
REQ_UNDER_DEP="REQ-eeee0002-0000-4000-8000-000000000024"
REQ_MIXED="REQ-eeee0003-0000-4000-8000-000000000025"
REQ_DEP_UNDER_DEP="REQ-eeee0004-0000-4000-8000-000000000026"
REQ_DRAFT="REQ-eeee0005-0000-4000-8000-000000000027"

# <リポジトリ> <ファイル名> <ID> <name> <status> <refines の先>
use_case_item() {
  cat >"$1/docs/$2.md" <<MD
---
id: "$3"
type: use_case
name: "$4"
status: $5
refines:
  - "$6"
---
# $4
MD
}

# <リポジトリ> <ファイル名> <ID> <name> <status> <derives_from の先…>
requirement_item() {
  local repo=$1 file=$2 id=$3 name=$4 status=$5
  shift 5
  {
    printf -- '---\nid: "%s"\ntype: requirement\nname: "%s"\nsection: product-scope\nstatus: %s\nderives_from:\n' "$id" "$name" "$status"
    printf '  - "%s"\n' "$@"
    printf 'specification: |\n  The fixture SHALL keep this requirement.\nspecification_ja: |\n  fixture はこの要求を保たなければならない。\n---\n# %s\n' "$name"
  } >"$repo/docs/$file.md"
}

upstream="$work/upstream"
make_fixture "$upstream"
use_case_item "$upstream" uc-depreq "$UC_DEPREQ" "廃止した要件しか持たないユースケース" stable "$SOL_ID"
use_case_item "$upstream" uc-dep "$UC_DEP" "廃止したユースケース" deprecated "$SOL_ID"
use_case_item "$upstream" uc-draft "$UC_DRAFT" "draft の要件を持つ draft のユースケース" draft "$SOL_ID"
use_case_item "$upstream" uc-dep-empty "$UC_DEP_EMPTY" "要件を持たない廃止したユースケース" deprecated "$SOL_ID"
requirement_item "$upstream" req-dep "$REQ_DEP" "廃止した要件" deprecated "$UC_DEPREQ"
requirement_item "$upstream" req-under-dep "$REQ_UNDER_DEP" "廃止したユースケースの下の要件" stable "$UC_DEP"
requirement_item "$upstream" req-mixed "$REQ_MIXED" "有効な親も持つ要件" stable "$UC_DEP" "$UC_ID"
requirement_item "$upstream" req-dep-under-dep "$REQ_DEP_UNDER_DEP" "廃止したユースケースの下の廃止した要件" deprecated "$UC_DEP"
requirement_item "$upstream" req-draft "$REQ_DRAFT" "draft の要件" draft "$UC_DRAFT"

run_gap env SARA_GAP_ROOT="$upstream" sara-gap
upstream_out="$stdout_capture"
assert_eq "use_case と requirement のつながりの欠けがあれば exit 1" 1 "$status_capture"
sec_uc_noreq="$(section_body "$h_uc_noreq" "$upstream_out")"
sec_req_depuc="$(section_body "$h_req_depuc" "$upstream_out")"
assert_eq "deprecated の requirement しか持たない有効な use_case だけを出し、requirement の無い deprecated の use_case は出さない" \
  "$UC_DEPREQ"$'\t'"廃止した要件しか持たないユースケース"$'\t'"docs/uc-depreq.md" "$sec_uc_noreq"
assert_eq "親の use_case がすべて deprecated の有効な requirement だけを出す" \
  "$REQ_UNDER_DEP"$'\t'"廃止したユースケースの下の要件"$'\t'"docs/req-under-dep.md" "$sec_req_depuc"

run_gap env SARA_GAP_ROOT="$upstream" sara-gap --json
assert_eq "--json の use_case_without_requirement と requirement_under_deprecated_use_case" \
  "$UC_DEPREQ:$REQ_UNDER_DEP" \
  "$(jq -r '"\([.use_case_without_requirement[].id] | join(",")):\([.requirement_under_deprecated_use_case[].id] | join(","))"' <<<"$stdout_capture" 2>/dev/null)"
assert_eq "--json の新しい節の行のキーは id / name / file だけ" '["file,id,name"]' \
  "$(jq -c '[.use_case_without_requirement, .requirement_under_deprecated_use_case | .[] | keys | join(",")] | unique' <<<"$stdout_capture" 2>/dev/null)"

# 有効な requirement を持つ use_case と、有効な親を持つ requirement だけのグラフでは、どちらの節も空になる。
run_gap env SARA_GAP_ROOT="$base" sara-gap --json
assert_eq "use_case と requirement がつながっていれば新しい 2 節は空" "0:0" \
  "$(jq -r '"\(.use_case_without_requirement | length):\(.requirement_under_deprecated_use_case | length)"' <<<"$stdout_capture" 2>/dev/null)"

# 有効な use_case が無くなった requirement だけが残っても exit 1 になる（到達率と節 1〜5 は埋めたまま）。
only_depuc="$work/only-depuc"
fill_gaps "$only_depuc"
use_case_item "$only_depuc" uc-dep "$UC_DEP" "廃止したユースケース" deprecated "$SOL_ID"
sed -i "s|\"$UC_ID\"|\"$UC_DEP\"|" "$only_depuc/docs/req-covered.md"
run_gap env SARA_GAP_ROOT="$only_depuc" sara-gap --json
assert_eq "親の use_case がすべて deprecated の requirement だけで exit 1" "1:1" \
  "$status_capture:$(jq -r '.requirement_under_deprecated_use_case | length' <<<"$stdout_capture" 2>/dev/null)"

only_noreq="$work/only-noreq"
fill_gaps "$only_noreq"
use_case_item "$only_noreq" uc-depreq "$UC_DEPREQ" "廃止した要件しか持たないユースケース" stable "$SOL_ID"
run_gap env SARA_GAP_ROOT="$only_noreq" sara-gap --json
assert_eq "有効な requirement を持たない use_case だけで exit 1" "1:1" \
  "$status_capture:$(jq -r '.use_case_without_requirement | length' <<<"$stdout_capture" 2>/dev/null)"

# --- 4c. 有効な risk を持たない品質特性 ---------------------------------------
#
# base の risk はどれも reliability なので、TSV が無ければ残りの 8 特性を enum の順に出す。

run_gap env SARA_GAP_ROOT="$base" sara-gap
assert_eq "TSV が無ければ risk の無い 8 特性を enum の順に 1 行ずつ出す" \
  "$(printf '%s\n' "${unrisked_characteristics[@]}")" \
  "$(section_body "$h_qc" "$stdout_capture" | grep -v '^$')"
run_gap env SARA_GAP_ROOT="$base" sara-gap --json
assert_eq "--json の quality_characteristic_without_risk は特性の名前の配列" \
  '["functional_suitability","performance_efficiency","compatibility","interaction_capability","security","maintainability","flexibility","safety"]' \
  "$(jq -c '.quality_characteristic_without_risk' <<<"$stdout_capture" 2>/dev/null)"

# <リポジトリ> <ファイル名> <ID> <品質特性> <status>
risk_item() {
  cat >"$1/docs/$2.md" <<MD
---
id: "$3"
type: risk
name: "$4 のリスク"
section: foundation
status: $5
threatens:
  - "REQ-aaaa0001-0000-4000-8000-000000000003"
likelihood: low
impact: low
level: low
quality_characteristic: $4
---
# $4 のリスク
MD
}

qc="$work/qc"
make_fixture "$qc"
risk_item "$qc" risk-security "RISK-ffff0001-0000-4000-8000-000000000030" security deprecated
risk_item "$qc" risk-safety "RISK-ffff0002-0000-4000-8000-000000000031" safety draft
write_exclusions "$work/exclusions-qc.tsv" compatibility flexibility
run_gap env SARA_GAP_ROOT="$qc" SARA_GAP_EXCLUSIONS="$work/exclusions-qc.tsv" sara-gap --json
qc_json="$stdout_capture"
assert_eq "deprecated の risk しか持たない特性は出し、draft の risk を持つ特性と対象外の特性は出さない" \
  "functional_suitability,performance_efficiency,interaction_capability,security,maintainability" \
  "$(jq -r '.quality_characteristic_without_risk | join(",")' <<<"$qc_json" 2>/dev/null)"

# 環境変数のパスは既定のパスより優先し、ヘッダだけの TSV は何も対象外にしない。
write_exclusions "$work/exclusions-header-only.tsv"
qc_only="$work/qc-only"
fill_gaps "$qc_only"
run_gap env SARA_GAP_ROOT="$qc_only" SARA_GAP_EXCLUSIONS="$work/exclusions-header-only.tsv" sara-gap --json
assert_eq "SARA_GAP_EXCLUSIONS のヘッダだけの TSV が既定のパスに代わり、品質特性の欠けだけで exit 1" "1:8" \
  "$status_capture:$(jq -r '.quality_characteristic_without_risk | length' <<<"$stdout_capture" 2>/dev/null)"
run_gap env SARA_GAP_ROOT="$qc_only" SARA_GAP_EXCLUSIONS="$work/no-such.tsv" sara-gap --json
assert_eq "SARA_GAP_EXCLUSIONS のファイルが無ければ対象外なしとして動く" "1:8" \
  "$status_capture:$(jq -r '.quality_characteristic_without_risk | length' <<<"$stdout_capture" 2>/dev/null)"
run_gap env SARA_GAP_ROOT="$qc_only" sara-gap --json
assert_eq "既定のパスの TSV で対象外にした特性は出さない" "0:0" \
  "$status_capture:$(jq -r '.quality_characteristic_without_risk | length' <<<"$stdout_capture" 2>/dev/null)"

# --- 4d. human_judgement を持つ test_condition --------------------------------
#
# 有効で値の空でない human_judgement を持つ test_condition だけを一覧にし、exit には数えない。

add_judgement() {
  sed -i "s/^status: \(.*\)\$/status: \1\nhuman_judgement: \"$2\"/" "$1"
}

hj="$work/hj"
make_fixture "$hj"
add_judgement "$hj/docs/tc-covered.md" "見た目の崩れは人が判断する"
add_judgement "$hj/docs/tc-gap.md" "廃止したテスト条件の判断"
sed -i 's/^status: stable$/status: deprecated/' "$hj/docs/tc-gap.md"
cat >"$hj/docs/tc-empty-judgement.md" <<'MD'
---
id: "TC-33330003-0000-4000-8000-000000000032"
type: test_condition
name: "human_judgement が空のテスト条件"
status: stable
human_judgement: ""
mitigates:
  - "RISK-11110001-0000-4000-8000-000000000006"
---
# TC-33330003: human_judgement が空のテスト条件
MD
run_gap env SARA_GAP_ROOT="$hj" sara-gap
assert_eq "有効で human_judgement を持つ test_condition だけを <フル ID>\\t<name>\\t<file> で出す" \
  "TC-33330001-0000-4000-8000-000000000008"$'\t'"CASE に covers されているテスト条件"$'\t'"docs/tc-covered.md" \
  "$(section_body "$h_hj" "$stdout_capture" | grep -v '^$')"
run_gap env SARA_GAP_ROOT="$hj" sara-gap --json
assert_eq "--json の human_judgement の行は id / name / file" '[{"file":"docs/tc-covered.md","id":"TC-33330001-0000-4000-8000-000000000008","name":"CASE に covers されているテスト条件"}]' \
  "$(jq -c '[.human_judgement[] | to_entries | sort_by(.key) | from_entries]' <<<"$stdout_capture" 2>/dev/null)"

hj_clean="$work/hj-clean"
fill_gaps "$hj_clean"
add_judgement "$hj_clean/docs/tc-covered.md" "見た目の崩れは人が判断する"
run_gap env SARA_GAP_ROOT="$hj_clean" sara-gap --json
assert_eq "human_judgement の一覧だけがあっても exit 0" "0:1" \
  "$status_capture:$(jq -r '.human_judgement | length' <<<"$stdout_capture" 2>/dev/null)"

# --- 4e. deprecated の item からの辺 -------------------------------------------
#
# ギャップを埋めた fixture で、覆う側の item を 1 つずつ deprecated にする。
# その item からの辺は数えず、覆われていた有効な item が未カバーに出て到達率からも外れる。

deprecate() {
  sed -i 's/^status: stable$/status: deprecated/' "$@"
}

# <ラベル> <期待> <jq の式>。直前の run_gap の --json の出力に式を当てる。
assert_json() {
  assert_eq "$1" "$2" "$(jq -r "$3" <<<"$stdout_capture" 2>/dev/null)"
}

ids='map(.id[0:13]) | join(",")'
reach='"\(.total),\(.reached)"'

dep_risk="$work/dep-risk"
fill_gaps "$dep_risk"
deprecate "$dep_risk/docs/risk-covered.md"
run_gap env SARA_GAP_ROOT="$dep_risk" sara-gap --json
assert_json "deprecated の risk からの threatens は REQ を覆わず、その risk は節 2 に出ない" \
  "1:REQ-aaaa0001:0:1,0" \
  "\"\(.unthreatened | length):\(.unthreatened[0].id[0:12]):\(.unmitigated | length):\(.reach.requirement | $reach)\""

dep_tc="$work/dep-tc"
fill_gaps "$dep_tc"
deprecate "$dep_tc/docs/tc-covered.md"
run_gap env SARA_GAP_ROOT="$dep_tc" sara-gap --json
assert_json "deprecated の TC からの mitigates は RISK を覆わず、その TC は節 3 に出ない" \
  "RISK-11110001:0:1,0" \
  "\"\(.unmitigated | $ids):\(.uncovered | length):\(.reach.requirement | $reach)\""

dep_case="$work/dep-case"
fill_gaps "$dep_case"
deprecate "$dep_case/docs/case.md" "$dep_case/docs/case-followed.md"
run_gap env SARA_GAP_ROOT="$dep_case" sara-gap --json
assert_json "deprecated の CASE からの covers と follows は数えず、その CASE は節 4 に出ない" \
  "TC-33330001-0:0:1,0:1,0" \
  "\"\(.uncovered | $ids):\(.unfollowed | length):\(.reach.requirement | $reach):\(.reach.test_plan | $reach)\""

dep_inf="$work/dep-inf"
fill_gaps "$dep_inf"
deprecate "$dep_inf/docs/inf.md"
run_gap env SARA_GAP_ROOT="$dep_inf" sara-gap --json
assert_json "deprecated の INF からの satisfies は QA を覆わない" \
  "QA-88880001-0:1,0" \
  "\"\(.unsatisfied_quality | $ids):\(.reach.quality | $reach)\""

# follows の先がすべて deprecated の test_plan である有効な CASE は、follows を持っていても節 4 に出す。
dep_tp="$work/dep-tp"
fill_gaps "$dep_tp"
deprecate "$dep_tp/docs/tp.md"
run_gap env SARA_GAP_ROOT="$dep_tp" sara-gap --json
assert_json "follows の先がすべて deprecated の TP である CASE を節 4 に出す" \
  "CASE-55550001,CASE-66660002:0,0" \
  "\"\(.unfollowed | $ids):\(.reach.test_plan | $reach)\""

# design 側の risk の印は、design と risk の両方が有効なときだけ付ける。
for dep_file in dsg-gap risk-on-design; do
  dep_mark="$work/dep-mark-$dep_file"
  make_fixture "$dep_mark"
  deprecate "$dep_mark/docs/$dep_file.md"
  run_gap env SARA_GAP_ROOT="$dep_mark" sara-gap
  dep_mark_sec="$(section_body "$h_unthreatened" "$stdout_capture")"
  assert_has "$dep_file.md が deprecated でも REQ は節 1 に出る" '^REQ-dddd0004' "$dep_mark_sec"
  assert_lacks "$dep_file.md が deprecated なら design 側の risk の印を付けない" "^REQ-dddd0004.*$design_mark" "$dep_mark_sec"
done

# draft の item は有効な item で、その辺も数える。
draft_chain="$work/draft-chain"
fill_gaps "$draft_chain"
sed -i 's/^status: stable$/status: draft/' "$draft_chain"/docs/{risk-covered,tc-covered,case,case-followed,inf,tp}.md
run_gap env SARA_GAP_ROOT="$draft_chain" sara-gap --json
assert_json "draft の item からの辺は数え、exit 0 になる" "0:1,1,1" \
  "\"$status_capture:\([.reach.requirement, .reach.test_plan, .reach.quality | .ratio] | join(\",\"))\""

# --- 5. sara check が失敗するグラフでは exit 2 ---------------------------------
#
# broken reference（実在しない risk への mitigates）を混ぜ、ギャップ一覧を出さないことを確かめる。

broken="$work/broken"
make_fixture "$broken"
cat >"$broken/docs/broken.md" <<'MD'
---
id: "TC-99990009-0000-4000-8000-00000000000b"
type: test_condition
name: "壊れた参照を持つテスト条件"
mitigates:
  - "RISK-deadbeef-0000-4000-8000-00000000000c"
---
# TC-99990009: 壊れた参照を持つテスト条件
MD

run_gap env SARA_GAP_ROOT="$broken" sara-gap
if [[ "$status_capture" -eq 2 ]]; then
  pass "sara check が失敗するグラフでは exit 2"
else
  fault "sara check が失敗するグラフでは exit 2（実際: exit=$status_capture）"
fi
if [[ -z "$stdout_capture" ]]; then
  pass "sara check 失敗時はギャップ一覧を stdout に出さない"
else
  fault "sara check 失敗時はギャップ一覧を stdout に出さない（実際: $stdout_capture）"
fi

# --- 6. JSON 形状異常では exit 2（seam）----------------------------------------
#
# SARA_GAP_SARA seam で偽 sara を差し込み、JSON 形状の異常を再現する。
# shebang はサンドボックスに /usr/bin/env が無いため実行中の bash の絶対パスを埋め込む。

fake_noitems="$work/fake-sara-noitems"
{
  printf '#!%s\n' "$BASH"
  printf 'printf %%s "{}"\n'
} >"$fake_noitems"
chmod +x "$fake_noitems"

run_gap env SARA_GAP_ROOT="$base" SARA_GAP_SARA="$fake_noitems" sara-gap
if [[ "$status_capture" -eq 2 ]]; then
  pass ".items 配列が無い JSON では exit 2"
else
  fault ".items 配列が無い JSON では exit 2（実際: exit=$status_capture）"
fi

fake_invalid="$work/fake-sara-invalid"
{
  printf '#!%s\n' "$BASH"
  printf "printf %%s '{\"items\": [], \"valid\": false}'\n"
} >"$fake_invalid"
chmod +x "$fake_invalid"

run_gap env SARA_GAP_ROOT="$base" SARA_GAP_SARA="$fake_invalid" sara-gap
if [[ "$status_capture" -eq 2 ]]; then
  pass "exit 0 でも valid: false の JSON では exit 2"
else
  fault "exit 0 でも valid: false の JSON では exit 2（実際: exit=$status_capture）"
fi

# item が 0 件のグラフは全 reach の total が 0 で、ratio は 1 として exit 0 にする。
fake_empty="$work/fake-sara-empty"
{
  printf '#!%s\n' "$BASH"
  printf "printf %%s '{\"items\": [], \"valid\": true}'\n"
} >"$fake_empty"
chmod +x "$fake_empty"

run_gap env SARA_GAP_ROOT="$base" SARA_GAP_SARA="$fake_empty" SARA_GAP_EXCLUSIONS="$excl_all" sara-gap --json
assert_eq "item が 0 件なら reach の ratio は 1 で exit 0" "0:1,1,1" \
  "$status_capture:$(jq -r '[.reach.requirement, .reach.test_plan, .reach.quality | .ratio] | join(",")' <<<"$stdout_capture" 2>/dev/null)"

# --- 7. 走査先をリポジトリルート基準で解決する ---------------------------------
#
# SARA_GAP_ROOT 無しでサブディレクトリから実行しても git ルートの sara.toml / docs を対象にする。

gitrepo="$work/gitrepo"
make_fixture "$gitrepo"
git -C "$gitrepo" init -q
mkdir -p "$gitrepo/sub"
sub_status=0
(cd "$gitrepo/sub" && sara-gap >/dev/null 2>&1) || sub_status=$?
if [[ "$sub_status" -eq 1 ]]; then
  pass "サブディレクトリから叩いても git ルートのグラフを対象にする（ギャップ検出 = exit 1）"
else
  fault "サブディレクトリから叩いても git ルートのグラフを対象にする（実際: exit=$sub_status）"
fi

# --- 8. 引数の異常系 ------------------------------------------------------------

run_gap sara-gap --help
if [[ "$status_capture" -eq 0 ]]; then
  pass "--help は exit 0"
else
  fault "--help は exit 0（実際: exit=$status_capture）"
fi

run_gap sara-gap --bogus
if [[ "$status_capture" -eq 2 ]]; then
  pass "未知の引数は exit 2"
else
  fault "未知の引数は exit 2（実際: exit=$status_capture）"
fi

run_gap sara-gap --json extra
if [[ "$status_capture" -eq 2 ]]; then
  pass "引数過多は exit 2"
else
  fault "引数過多は exit 2（実際: exit=$status_capture）"
fi

exit "$fail"

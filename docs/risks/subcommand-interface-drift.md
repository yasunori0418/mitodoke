---
id: "RISK-b7954f84-33d6-419f-ab16-ae6313590e36"
type: risk
name: "exit code、--json、--check、英語の text 出力がサブコマンドによって食い違う"
description: "exit code、--json、--check、英語の text 出力がサブコマンドによって食い違う"
likelihood: medium
impact: medium
level: medium
quality_characteristic: interaction_capability
section: foundation
status: stable
threatens:
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:02:41+09:00"
---
# exit code、--json、--check、英語の text 出力がサブコマンドによって食い違う

## リスク

サブコマンドの外から見える約束が、サブコマンドによって食い違う懸念である。
[サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md)
と [1 つの CLI が、サブコマンドごとに入力・出力・exit code を定める](../requirements/single-cli-subcommand-contracts.md)
は、ほかのツールと組み合わせられるように、それぞれのサブコマンドが入力・出力・exit code を定めることを
求める。失敗の向きは次のものがある。

- exit code の 0・1・2 の意味がサブコマンドによって違う
- `--json` を持たないサブコマンドがある
- `index` と `model` の `--check` が、差分があっても exit code 1 で終わらない
- 既定の text 出力の見出しや診断の文が英語でないか、言語を切り替える仕組みを持つ

どの向きも、CLI を組み合わせる側が結果を取り違える点で同じ重さである。exit code の意味の食い違いは、
それに頼るスクリプトが誤った分岐を取るまで表に出ない。sara-core を組み込む規則は
[sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる](sara-core-breaking-change-alters-results.md)
が持ち、この risk はサブコマンドの間で約束が揃っているかだけを持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。10 のサブコマンドがあり、`--check` は `index` と `model`
だけが持つなど、約束がサブコマンドによって分かれる。見逃しやすさは低い。写した契約テストは
`dev/tests/sara-gap.sh`・`dev/tests/sara-fresh.sh`・`dev/tests/sara-new.sh`・`dev/tests/sara-verify.sh` で
exit code を、`dev/tests/okf-index.sh` で index の差分の検出を確かめている。

impact は medium とした。約束の食い違いは出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

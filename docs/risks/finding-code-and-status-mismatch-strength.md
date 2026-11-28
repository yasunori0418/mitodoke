---
id: "RISK-c4427537-6f65-48c9-bc61-89f5b88a16a6"
type: risk
name: "指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う"
description: "指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: foundation
status: stable
threatens:
  - "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:02:41+09:00"
---
# 指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う

## リスク

指摘に付けるコードの接頭辞（`E_MITODOKE_` か `W_MITODOKE_`）、item の `status`、指摘の置き場所が、その実行で
指摘に働く強さと食い違う懸念である。置き場所は、指摘を item の `error` に置くか `warnings` に置くかを指す。
[契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す](../requirements/error-and-warning-codes.md)
と [check・gap・fresh の item は契約と文書の組を単位とする](../requirements/result-item-unit.md) は、exit code を
0 でなくする指摘を失敗、しない指摘を報告とし、3 つをその強さに揃えることを求める。失敗の向きは次のものがある。

- 強さの設定で報告にした指摘に `E_MITODOKE_` を付けるか、`status` を failed にする。逆も含む
- 強さを切り替えたときに、接頭辞だけでなく契約名まで変わる
- 報告の指摘だけを持つ組を item にしない
- `check` が見つけた違反に、outturn の共通コードの `E_PRECONDITION` を使う

どの向きも、エンベロープを読む側が指摘の重さを取り違える点で同じ重さである。exit code と item の中身が
食い違っても、どちらか片方しか見ない読み手には誤りが見えない。エンベロープの形そのものの食い違いは
[結果エンベロープの形がサブコマンドによって食い違う](envelope-shape-diverges-across-subcommands.md) が持つ。

## 実現性

likelihood は medium とした。変わりやすさは低い。3 つの値は、指摘が exit code を 0 でなくするかという 1 つの
入力から表の 3 行で決まり、規則に例外が少ない。見逃しやすさは高い。写した契約テストはコードも item の
`status` も出さないので、この対応を確かめていない。

impact は medium とした。重さを取り違えた結果は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

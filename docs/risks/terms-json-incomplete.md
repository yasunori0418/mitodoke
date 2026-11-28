---
id: "RISK-c62b884b-ddbe-45f3-98c8-e1c622a17bb5"
type: risk
name: "用語の一覧の JSON から用語か avoid の綴りが欠ける"
description: "用語の一覧の JSON から用語か avoid の綴りが欠ける"
likelihood: low
impact: medium
level: low
quality_characteristic: functional_suitability
section: result-handoff
status: stable
threatens:
  - "REQ-f78bd468-dd61-4564-9287-aec3a8ad6ba4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:11:46+09:00"
---
# 用語の一覧の JSON から用語か avoid の綴りが欠ける

## リスク

[用語の一覧と avoid を JSON で出力する](../requirements/terms-and-avoid-exported-as-json.md)
が破れ、出力した JSON から一部が欠ける懸念である。失敗の向きは次の 2 つある。

- 用語 item の一部が一覧に載らない
- 載った用語の `avoid` の綴りの一部が欠ける

最も重い向きは、`avoid` の綴りが欠ける向きで、この risk はこの向きで採点する。適用先の製品はこの JSON
から避ける綴りの検査を組み立てるので、欠けた綴りは検査の対象から外れ、文書に残っても指摘されない。
検査が通ることは欠けの兆候にならない。用語が欠ける向きも、検査への影響はその用語の `avoid` の綴りが
欠けることに帰着する。

## 実現性

likelihood は low とした。変わりやすさは低い。採点した向きの規則は、すべての用語 item の `avoid` を写す
ことだけで、分岐を持たない。見逃しやすさは高い。写した `dev/tests/term-avoid.sh` は、用語 item の
`avoid` から辞書を作り、綴りが 1 件も無ければ失敗するが、すべての綴りが辞書に載ったかは確かめていない。
変わりやすさと見逃しやすさの片方だけが高いときは medium とする読み替えの規則に当てると medium になる。
それでも low としたのは、期待する一覧を `dev/tests/term-avoid.sh` が辞書を作るのと同じ問い合わせで作れ、
出力と突き合わせる確かめ方をそのまま写せるためである。

impact は medium とした。欠けた綴りは出荷物の誤動作だが、直した版で JSON を出し直し、検査をやり直せば
回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

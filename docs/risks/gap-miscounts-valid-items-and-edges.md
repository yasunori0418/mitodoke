---
id: "RISK-915697df-42e9-4d4e-baa3-72153ff25268"
type: risk
name: "gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する"
description: "gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: inspection
status: stable
threatens:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-05cc6e6a-6440-429f-8447-16bd7b192d9c"
  - "REQ-f319e7d0-8a0b-4c3f-92fc-b855e7e90652"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する

## リスク

`gap` が数える item と辺を誤り、つながりの欠けを見逃すか余分に報告する懸念である。
[検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md)
は、`gap` がすべての節で有効な item だけを数え、辺は両端が有効な item のものだけを数えることを求める。
失敗の向きは次の 4 つある。

- `deprecated` の item を数え、`deprecated` の risk から `threatens` された requirement を覆われたと
  みなすなど、欠けを見逃す
- 片方の端が `deprecated` の辺を数え、同じく欠けを見逃す。`follows` の先がすべて `deprecated` の
  test_plan である test_case を、`follows` を持つとみなす向きもここに入る
- `deprecated` の item 自体を欠けとして挙げ、余分に報告する
- [gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする](../requirements/gap-reports-upstream-and-quality-characteristic-gaps.md)
  の節で、`deprecated` の requirement しか持たない use_case、親がすべて `deprecated` の requirement、
  `deprecated` の risk しか持たない品質特性を報告しない

[組み込みの relation は上流の 8 つと peer の 3 つとし、保証する連鎖は requirement → risk → test_condition → test_case とする](../requirements/builtin-relations-and-guaranteed-chain.md)
への辺は、この連鎖の欠けを数えることと、design を連鎖の任意の中継点として未カバーの指標に数えないことを
指す。design を数えると、risk を持たない design が余分に報告される。

最も重い向きは、`deprecated` の item や辺を数えて欠けを見逃す向きで、この risk はこの向きで採点する。
見逃された欠けは報告に出ないので、誤りは表に出ない。余分な報告は利用者が読めば誤りと分かる。
`fresh` の側で同じ数え方を誤る懸念は
[基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する](stale-item-missed-or-overreported.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。節は 7 つあり、item と辺の両方に有効かの判定を当て、
同じ判定を `fresh` と共有する。見逃しやすさは低い。写した `dev/tests/sara-gap.sh` は、`deprecated` の
risk・test_condition・test_case・infrastructure からの辺が覆ったことにならないこと、`follows` の先が
すべて `deprecated` の test_case を挙げること、`deprecated` を考えた use_case と requirement の節、
`deprecated` の risk しか持たない品質特性、design を列挙しないことを確かめている。

impact は medium とした。数え誤った報告は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

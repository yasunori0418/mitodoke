---
id: "RISK-522048a1-0b1a-456c-9e65-dd673038d421"
type: risk
name: "人の確認の無い item、期限切れ、間隔の超過の報告で、数える verified か起点を誤る"
description: "人の確認の無い item、期限切れ、間隔の超過の報告で、数える verified か起点を誤る"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: freshness
status: stable
threatens:
  - "REQ-f27d4510-f215-403e-beda-b39fa824e368"
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:25+09:00"
---
# 人の確認の無い item、期限切れ、間隔の超過の報告で、数える verified か起点を誤る

## リスク

[fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する](../requirements/fresh-reports-unverified-validation-and-expiry.md)
の報告で、数える `verified` か期限の起点を誤る懸念である。失敗の向きは次の 4 つある。

- `human:` 以外の actor の `verified` を人の確認に数え、人の確認の無い solution と use_case を見逃す
- `at` が `generated.at` より前の `verified` を人の確認に数え、同じく見逃す
- 期限の間隔の起点に、`generated.at` より前の確認や `human:` 以外の確認を使う
- `deprecated` の item を報告するか、間隔を設定していない型を検査する

[OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](../requirements/constraints-on-top-of-okf.md)
への辺は、人の確認として数えるのは `at` が `generated.at` 以降の `verified` の要素だけで、それより前の要素は
違反にしないという数え方の規則を指す。この規則を違反の条件と取り違えると、前の要素を持つ item を `check` が
失敗にする。

最も重い向きは、数えてはいけない `verified` を人の確認に数えて見逃す向きで、この risk はこの向きで
採点する。古い確認やエージェントの確認が人の確認の代わりに通り、誤りは表に出ない。人の確認の無い
high の risk の報告も同じ数え方を使う。

## 実現性

likelihood は medium とした。変わりやすさは高い。人の確認の数え方は actor と時刻の 2 つの条件を持ち、
期限切れと間隔の超過にそれぞれの規則があり、間隔は型ごとの設定に依る。同じ数え方を `fresh` と `check` の
見直しの義務が共有する。見逃しやすさは低い。写した `dev/tests/sara-fresh.sh` は、エージェントの
確認だけの item、`generated.at` より前と同じ時刻の人の確認、`deprecated` の item、期限切れ、起点が人の確認で
進むこと、間隔を設定していない型を検査しないことを確かめている。

impact は medium とした。誤った報告は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

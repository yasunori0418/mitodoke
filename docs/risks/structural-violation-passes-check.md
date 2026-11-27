---
id: "RISK-ebcb52c9-5184-4b17-b952-d92b097a5c54"
type: risk
name: "check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない"
description: "check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない"
likelihood: high
impact: medium
level: high
quality_characteristic: functional_suitability
section: inspection
status: stable
threatens:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
  - "REQ-9c54aa84-e2db-42d7-87af-f1fec5c64a63"
  - "REQ-3f258649-995e-404f-8bda-52fba8c0281d"
  - "REQ-5c52b41a-9015-4c68-8143-b813f13064fa"
  - "REQ-a69187a5-ad91-4cee-bf29-efa34e79f812"
  - "REQ-cfa09935-9066-433a-a3ef-05ca83ad9a22"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない

## リスク

`check` が構造の契約の違反を見逃し、違反を持つ item を通す懸念である。
[検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md)
は構造の契約を閉じた列挙で定め、`deprecated` の item にも働かせることを求める。見逃しの向きは、列挙の
項目を定める次の要件ごとにある。

- [OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する](../requirements/okf-key-inspection.md):
  OKF のキーの形と値、未来の時刻
- [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](../requirements/constraints-on-top-of-okf.md):
  1 つの mapping の `verified`、`generated` と `status` の欠け
- [宣言の無い frontmatter のキーは構造の契約の違反とする](../requirements/undeclared-frontmatter-keys.md):
  ほかの型だけで宣言されたフィールドを含む、宣言の無いキー
- [test_case は covers と follows をそれぞれ 1 本以上持たなければならない](../requirements/test-case-link-contract.md):
  sara の検査が通す、どちらか 1 本だけの test_case
- [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](../requirements/type-locations-in-config.md):
  型と置き場所の不一致
- [generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む](../requirements/generated-by-format.md):
  既存の item の拒む値
- [level の導出表は設定で変えられ、設定が無ければ既定の表を使う](../requirements/risk-matrix-configuration.md):
  導出表と合わない `level`

最も重い向きは、`deprecated` の item に構造の契約を働かせない向きで、この risk はこの向きで採点する。
`gap` と `fresh` が `deprecated` の item を数えないことに引きずられて、`check` も外すと、`deprecated` の
item の壊れた frontmatter はどの検査にも掛からない。違反を見逃した `check` は exit code 0 で終わるので、
誤りは表に出ない。

## 実現性

likelihood は high とした。変わりやすさは高い。構造の契約は 13 項目あり、`deprecated` を外す `gap` と
`fresh` とは逆の扱いをし、拒む値の判定を `new` と共有する。見逃しやすさも高い。写した契約テストのうち
`dev/tests/okf-frontmatter.sh` は OKF のキーの形・未来の時刻・リストでない `verified`・`generated` の欠けを、
`dev/tests/risk-matrix.sh` は `level` の導出を確かめている。宣言の無いキー、`covers` と `follows` の両方、
型と置き場所の一致は、どの契約テストも確かめていない。`deprecated` の item を違反の側に置いたフィクスチャも
無い。

impact は medium とした。見逃した違反は出荷物の誤動作だが、検査を直して再実行すれば見つかる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

---
id: "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
type: requirement
name: "検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は報告とし、どの検査の強さも設定で変えられるようにする。"
specification: |
  By default, a violation of a structural contract SHALL be a failure. The structural
  contracts SHALL include `sara check` (including a `solution` lacking `stale_after`), the shape of the frontmatter, the placement of IDs,
  the one-to-one correspondence between test_case items and test assets, the derivation of
  a risk's `level`, the `deprecated` status of a `supersedes` target, and the difference in
  `index.md`. By default, a
  connection gap and a review obligation SHALL be reported without failing. The connection
  gaps SHALL include a test_condition that is not covered, a risk that is not mitigated, a
  requirement that is not threatened, a quality that is not satisfied, a valid use_case
  without a valid requirement, a valid requirement all of whose parent use_case items are
  deprecated, and a quality characteristic without a valid risk. The review obligations SHALL
  include an item awaiting review after an upstream change, a missing `generated` update, a
  high risk lacking a human verification, a valid solution or use_case lacking a human
  verification, an expired `stale_after`, and a `stale_after` beyond its interval. In
  these lists, valid SHALL mean that the `status` is not `deprecated`, `draft` included. The
  strength of every inspection SHALL be changeable in the configuration.
specification_ja: |
  既定では、構造の契約の違反は失敗としなければならない。構造の契約には、`sara check`（`solution` の `stale_after` の欠けを含む）、
  frontmatter の形、ID の置き場所、test_case とテスト資産の 1:1、risk の `level` の導出、
  `supersedes` の先が `deprecated` であること、`index.md` の差分を含めなければならない。
  既定では、つながりの欠けと見直しの
  義務は、失敗にせずに報告しなければならない。つながりの欠けには、covers されない
  test_condition、mitigates されない risk、threatens されない requirement、satisfies されない
  quality、有効な requirement を持たない有効な use_case、親の use_case がすべて deprecated の
  有効な requirement、有効な risk を持たない品質特性を含めなければならない。見直しの義務には、
  上流の変更による再確認待ち、generated の更新漏れ、人の確認が無い high の risk、人の確認が無い
  有効な solution と use_case、stale_after の期限切れ、stale_after の間隔の超過を含めなければ
  ならない。これらの列挙の「有効な」は、`status` が `deprecated` でないこと（`draft` を含む）と
  しなければならない。どの検査の強さも、設定で変えられなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
---
# 検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる

## 仕様

mitodoke の検査は、構造の契約、つながりの欠け、見直しの義務の 3 つに分かれる。既定では、
構造の契約の違反だけを失敗にし、つながりの欠けと見直しの義務は CI で報告する。

- 構造の契約: `sara check`（`solution` の `stale_after` の欠けを含む）、frontmatter の形、ID の置き場所、
  test_case とテスト資産の 1:1、risk の `level` の導出、`supersedes` の先が `deprecated` であること、
  `index.md` の差分
- つながりの欠け: covers されない test_condition、mitigates されない risk、threatens されない
  requirement、satisfies されない quality、有効な requirement を持たない有効な use_case、親の use_case が
  すべて deprecated の有効な requirement、有効な risk を持たない品質特性
- 見直しの義務: 上流の変更による再確認待ち、generated の更新漏れ、人の確認が無い high の risk、人の確認が
  無い有効な solution と use_case、stale_after の期限切れ、stale_after の間隔の超過

この列挙の「有効な」は、`status` が `deprecated` でないことを指し、`draft` を含む。`human_judgement` を持つ
test_condition の一覧は、人が判断する範囲を示す情報で、3 つの分類のどれにも当たらない。

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、適用先の製品が決める。

## 出典

根拠の決定は次の ADR が持つ。

- [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする](../adr/default-strength-fail-structure-report-gaps.md)

新しく足した検査の要件は次の item が持つ。

- [gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする](gap-reports-upstream-and-quality-characteristic-gaps.md)
- [fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する](fresh-reports-unverified-validation-and-expiry.md)

---
id: "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
type: requirement
name: "検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は報告とし、どの検査の強さも設定で変えられるようにする。"
specification: |
  By default, a violation of a structural contract SHALL be a failure. The structural
  contracts SHALL be the following: `sara check` (including a `solution` lacking
  `stale_after`), the shape of the frontmatter, the placement of IDs, the one-to-one
  correspondence between test_case items and test assets, the derivation of a risk's `level`,
  the `deprecated` status of a `supersedes` target, the difference in `index.md`, the `covers`
  and `follows` of a test_case, an undeclared frontmatter key, the shape and the values of the
  OKF keys, the constraints on top of OKF that are inspected as structural contracts, the match between a type and its location, and a
  duplicated test asset. By default, a connection gap and a review obligation SHALL be reported
  without failing. The connection gaps SHALL be the following: a test_condition that is not
  covered, a risk that is not mitigated, a requirement that is not threatened, a quality that is
  not satisfied, a valid use_case without a valid requirement, a valid requirement all of whose
  parent use_case items are deprecated, and a quality characteristic without a valid risk. The
  review obligations SHALL be the following: an item awaiting review after an upstream change, a
  missing `generated` update (an item whose body changed in the difference from the base revision
  while `generated.at` did not change), a high risk lacking a human verification, a valid
  solution or use_case lacking a human verification, an expired `stale_after`, and a
  `stale_after` beyond its interval. In these lists, valid SHALL mean that the `status` is not
  `deprecated`, `draft` included. The strength of every inspection SHALL be changeable in the
  configuration.
specification_ja: |
  既定では、構造の契約の違反は失敗としなければならない。構造の契約は、
  `sara check`（`solution` の `stale_after` の欠けを含む）、frontmatter の形、ID の置き場所、test_case と
  テスト資産の 1:1、risk の `level` の導出、`supersedes` の先が `deprecated` であること、`index.md` の差分、
  test_case の `covers` と `follows`、宣言の無い frontmatter のキー、OKF のキーの形と値、OKF に重ねる制約の
  うち構造の契約として検査するもの、型と置き場所の一致、テスト資産の重複でなければならない。既定では、つながりの欠けと見直しの義務は、失敗にせずに報告
  しなければならない。つながりの欠けは、covers されない test_condition、
  mitigates されない risk、threatens されない requirement、satisfies されない quality、有効な requirement
  を持たない有効な use_case、親の use_case がすべて deprecated の有効な requirement、有効な risk を持たない
  品質特性でなければならない。見直しの義務は、上流の変更による再確認待ち、generated の更新
  漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）、人の確認が
  無い high の risk、人の確認が無い有効な solution と use_case、stale_after の期限切れ、stale_after の
  間隔の超過でなければならない。これらの列挙の「有効な」は、`status` が `deprecated` でないこと（`draft` を含む）と
  しなければならない。どの検査の強さも、設定で変えられなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:22:37+09:00"
---
# 検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる

## 仕様

mitodoke の検査は、構造の契約、つながりの欠け、見直しの義務の 3 つに分かれる。既定では、
構造の契約の違反だけを失敗にし、つながりの欠けと見直しの義務は CI で報告する。

構造の契約は次のものとする。

- `sara check`（`solution` の `stale_after` の欠けを含む）
- frontmatter の形
- ID の置き場所
- test_case とテスト資産の 1:1
- risk の `level` の導出
- `supersedes` の先が `deprecated` であること
- `index.md` の差分
- test_case の `covers` と `follows`
- 宣言の無い frontmatter のキー
- OKF のキーの形と値
- OKF に重ねる制約のうち構造の契約として検査するもの
- 型と置き場所の一致
- テスト資産の重複

つながりの欠けは次のものとする。

- covers されない test_condition
- mitigates されない risk
- threatens されない requirement
- satisfies されない quality
- 有効な requirement を持たない有効な use_case
- 親の use_case がすべて deprecated の有効な requirement
- 有効な risk を持たない品質特性

見直しの義務は次のものとする。

- 上流の変更による再確認待ち
- generated の更新漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）
- 人の確認が無い high の risk
- 人の確認が無い有効な solution と use_case
- stale_after の期限切れ
- stale_after の間隔の超過

この列挙の「有効な」は、`status` が `deprecated` でないことを指し、`draft` を含む。`human_judgement` を持つ
test_condition の一覧は、人が判断する範囲を示す情報で、3 つの分類のどれにも当たらない。

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、適用先の製品が決める。

## 出典

根拠の決定は次の ADR が持つ。

- [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にし、それぞれの列挙を閉じる](../adr/default-strength-with-closed-lists.md)

新しく足した検査の要件は次の item が持つ。

- [gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする](gap-reports-upstream-and-quality-characteristic-gaps.md)
- [fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する](fresh-reports-unverified-validation-and-expiry.md)
- [test_case は covers と follows をそれぞれ 1 本以上持たなければならない](test-case-link-contract.md)
- [宣言の無い frontmatter のキーは構造の契約の違反とする](undeclared-frontmatter-keys.md)
- [OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する](okf-key-inspection.md)
- [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](constraints-on-top-of-okf.md)
- [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](type-locations-in-config.md)
- [テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](test-asset-inventory-sources.md)

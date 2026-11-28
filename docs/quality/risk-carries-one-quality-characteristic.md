---
id: "QA-3952eb05-440f-4287-925c-62dd136b6b89"
type: quality
name: "risk は ISO/IEC 25010:2023 の品質特性を 1 つ持ち、リスクを持たない特性は対象外の宣言を除いて列挙する"
description: "risk は ISO/IEC 25010:2023 の 9 つの品質特性から 1 つを quality_characteristic に持ち、有効な risk を持たない特性は、理由付きの対象外の宣言を除いて機械的に列挙する。"
specification: "Every `risk` SHALL carry exactly one `quality_characteristic`, chosen from the nine product quality characteristics of ISO/IEC 25010:2023. A risk that spans two characteristics SHALL be split into one risk per characteristic. A characteristic that no `risk` whose `status` is not `deprecated` carries SHALL be enumerated mechanically, except one that the product has declared out of scope together with a reason. A characteristic SHALL NOT be declared out of scope without a reason."
specification_ja: "すべての `risk` は ISO/IEC 25010:2023 の 9 つの製品品質特性から選んだ `quality_characteristic` を 1 つだけ持たなければならない。2 つの特性にまたがるリスクは、特性ごとの `risk` に分けなければならない。`status` が `deprecated` でない `risk` を 1 本も持たない特性は、製品が理由とともに対象外と宣言したものを除き、機械的に列挙されなければならない。理由を書かずに特性を対象外と宣言してはならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:50:32+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:09:53+09:00"
---
# risk は ISO/IEC 25010:2023 の品質特性を 1 つ持ち、リスクを持たない特性は対象外の宣言を除いて列挙する

## 仕様

risk が脅かす品質の側面を、ISO/IEC 25010:2023 の製品品質モデルの 9 つの品質特性で表す。値と日本語名の
対応は次のとおり。日本語名は JIS X 25010（2023 年版に対応する改正）から採る。

| `quality_characteristic` の値 | 品質特性 |
|---|---|
| `functional_suitability` | 機能適合性 |
| `performance_efficiency` | 性能効率性 |
| `compatibility` | 互換性 |
| `interaction_capability` | インタラクション容易性 |
| `reliability` | 信頼性 |
| `security` | セキュリティ |
| `maintainability` | 保守性 |
| `flexibility` | 柔軟性 |
| `safety` | 安全性 |

2 つの特性にまたがるリスクは、特性ごとに risk を分ける。どの特性にもリスクの検討が及んでいるかを、
特性ごとに数えて確かめられるようにするためである。

有効な risk を 1 本も持たない特性は列挙して報告する。製品が対象外にする特性は、理由とともに宣言して
列挙から外す。CLI の設定ファイルができるまでは、対象外の宣言を
`dev/tests/quality-characteristic-exclusions.tsv`（特性と理由の 2 列）に書く。

## 出典

根拠の決定は次の ADR が持つ。

- [risk に ISO/IEC 25010:2023 の品質特性を 1 つ必須で持たせる](../adr/risk-quality-characteristic.md)

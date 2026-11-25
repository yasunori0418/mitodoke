---
id: "ADR-0c7a1710-42ce-491b-9941-180ae38356aa"
type: adr
name: "mitodoke 自身が対象外にする品質特性を safety だけにする"
description: "mitodoke 自身が risk を起こさない品質特性を safety だけにし、理由を dev/tests/quality-characteristic-exclusions.tsv に書く。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "TP-8c2f612e-bc08-438f-a6cd-9b73028084b7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:06:59+09:00"
---
# mitodoke 自身が対象外にする品質特性を safety だけにする

- ステータス: stable
- 日付: 2026-11-24
- 関連: [risk に ISO/IEC 25010:2023 の品質特性を 1 つ必須で持たせる](risk-quality-characteristic.md), GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

risk は ISO/IEC 25010:2023 の 9 つの品質特性のどれか 1 つを持つ。有効な risk を 1 本も持たない特性は、
対象外と宣言したものを除いて `sara-gap` が報告する。対象外の特性と理由は
`dev/tests/quality-characteristic-exclusions.tsv` に書く。

mitodoke 自身がどの特性を対象外にするかを決める必要があった。

## 決定

mitodoke 自身が対象外にする品質特性は `safety`（安全性）だけにする。
`dev/tests/quality-characteristic-exclusions.tsv` に書く理由は次の文にする。

> mitodoke は手元と CI で文書を読み書きする CLI で、人の生命、健康、財産、環境に害を及ぼす動作を持たない。

## 根拠

残りの 8 つには mitodoke に当てはまるリスクがある。

- `performance_efficiency`（性能効率性）は数百本の item を持つドキュメントグラフでの実行時間
- `compatibility`（互換性）は sara、outturn、OKF との相互運用
- `interaction_capability`（インタラクション容易性）は text 出力、診断、`verify` の対話
- `security`（セキュリティ）は設定に書いたコマンドの実行と、人の識別子の詐称
- `flexibility`（柔軟性）はプラットフォームへの適応と導入
- `functional_suitability`・`reliability`・`maintainability` は CLI の機能そのものと保守

対象外にしない特性は、有効な risk を 1 本以上起こすまで、`sara-gap` が報告し続ける。

## 棄却した代替案

### performance_efficiency も対象外にする

性能の要件は今は 1 本も無いので、risk を張る先の要件が無い。ただし、数百本の item を持つドキュメント
グラフでの実行時間には、mitodoke に当てはまるリスクがある。

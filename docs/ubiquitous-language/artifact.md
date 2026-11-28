---
id: "UBQ-18108d2c-fb60-4d69-96b0-9f6af92d4dff"
type: ubiquitous_term
name: "artifact"
description: "品質について人間が検討・判断した結果として書き残すもの。"
name_ja: "成果物"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:17:35+09:00"
---
# artifact

## Definition

Something people write down as the outcome of considering and deciding on quality, such as
a requirement, a design, a risk, a test condition, a test plan or a test case. In the
document graph each artifact is recorded as an item, and the relations between them show
which downstream artifacts an upstream change may affect.

## 定義

品質について人間が検討・判断した結果として書き残すもの。要件・設計・リスク・テスト条件・
テスト計画・テストケースなどがある。ドキュメントグラフでは成果物を item として記録し、
その間の relation から、上流の変更が影響しうる下流の成果物をたどれるようにする。

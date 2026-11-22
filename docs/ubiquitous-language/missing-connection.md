---
id: "UBQ-bc3712a1-9e75-4143-8dc8-59976f800d99"
type: ubiquitous_term
name: "missing connection"
description: "検査の 3 つの分類の 1 つで、検証へ向かう連鎖が期待する relation を欠いた item を見つけるもの。"
name_ja: "つながりの欠け"
section: inspection
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
---
# missing connection

## Definition

One of the three categories of inspection: a check that finds items lacking a relation
the chain toward verification expects. It covers a test condition that no test case
covers, a risk that no test condition mitigates, a requirement that no risk threatens, a
quality item that no infrastructure item satisfies, a valid use case without a valid
requirement, a valid requirement all of whose parent use cases are deprecated, and a
quality characteristic that no valid risk carries. Valid here means that the `status` is
not `deprecated`, `draft` included. It names the category of
inspection; the state of an item that the inspection finds is called uncovered. By
default a missing connection is reported and does not fail.

## 定義

検査の 3 つの分類の 1 つで、検証へ向かう連鎖が期待する relation を欠いた item を見つけるもの。
どのテストケースにも `covers` されないテスト条件、どのテスト条件にも `mitigates` されない
リスク、どのリスクにも `threatens` されない要件、どの基盤にも `satisfies` されない品質、有効な
要件を持たない有効な要求、親の要求がすべて `deprecated` の有効な要件、有効なリスクを持たない品質
特性を含む。ここでの「有効な」は、`status` が `deprecated` でないことで、`draft` を含む。
つながりの欠けは検査の分類の名前で、その検査が見つける item の状態は未カバーと呼ぶ。既定では、
つながりの欠けは報告に留め、失敗にしない。

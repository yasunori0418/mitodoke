---
id: "UBQ-bc3712a1-9e75-4143-8dc8-59976f800d99"
type: ubiquitous_term
name: "missing connection"
description: "検査の 3 つの分類の 1 つで、検証へ向かう連鎖が期待する relation を欠いた item を見つけるもの。"
name_ja: "つながりの欠け"
section: inspection
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:53+09:00"
---
# missing connection

## Definition

One of the three categories of inspection: a check that finds items lacking a relation
the chain toward verification expects. It covers a test condition that no test case
covers, a risk that no test condition mitigates, a requirement that no risk threatens,
and a quality item that no infrastructure item satisfies. It names the category of
inspection; the state of an item that the inspection finds is called uncovered. By
default a missing connection is reported and does not fail.

## 定義

検査の 3 つの分類の 1 つで、検証へ向かう連鎖が期待する relation を欠いた item を見つけるもの。
どのテストケースにも `covers` されないテスト条件、どのテスト条件にも `mitigates` されない
リスク、どのリスクにも `threatens` されない要件、どの基盤にも `satisfies` されない品質を含む。
つながりの欠けは検査の分類の名前で、その検査が見つける item の状態は未カバーと呼ぶ。既定では、
つながりの欠けは報告に留め、失敗にしない。

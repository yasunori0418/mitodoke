---
id: "UBQ-05649c19-78ce-48cd-b4b4-e3efad173d53"
type: ubiquitous_term
name: "document graph"
description: "item を節、relation を辺とし、参照の正しさを機械的に検証するグラフ。"
name_ja: "ドキュメントグラフ"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
---
# document graph

## Definition

The graph whose nodes are items and whose edges are relations. It records what ought to
be, and does not hold events such as defects. Its references are verified mechanically:
every reference resolves, no ID is duplicated, and the graph has no cycles.

## 定義

item を節、relation を辺とするグラフ。そうあるべき姿を記録し、欠陥のような起きた出来事は
持たない。参照が解決すること、ID が重複しないこと、循環が無いことを機械的に検証する。

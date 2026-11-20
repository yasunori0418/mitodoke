---
id: "UBQ-dbf3eeb5-1212-4e90-a5c9-1077f646573c"
type: ubiquitous_term
name: "relation"
description: "item が frontmatter で別の item を指して張る、種類の付いた辺。"
avoid:
  - "リレーション"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
---
# relation

## Definition

A typed edge that an item declares in its frontmatter by listing the full IDs of the items
it points to. Each relation has a direction: upstream, downstream or peer. Which relations
exist and which types they may join are defined in `docs/model.yaml`.

## Avoid

- リレーション: a katakana spelling. Write relation.

## 定義

item が frontmatter に、指す item のフル ID を並べて張る、種類の付いた辺。relation は
上流・下流・peer のいずれかの向きを持つ。どの relation があり、どの型どうしを結べるかは
`docs/model.yaml` が定義する。

## 避ける表現

- リレーション: カタカナの表記。relation と書く。

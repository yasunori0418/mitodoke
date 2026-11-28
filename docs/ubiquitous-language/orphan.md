---
id: "UBQ-efc46003-0d42-4404-8f6f-e5a2691a326e"
type: ubiquitous_term
name: "orphan"
description: "上流の item にぶら下がるべきなのに、向きが上流の relation を 1 本も張っていない item の状態。"
name_ja: "接続漏れ"
avoid:
  - "張り忘れ"
  - "未接続"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:53+09:00"
---
# orphan

## Definition

The state of an item that should hang from an upstream item but declares no relation whose
direction is upstream. sara reports such an item as `Orphan item`. It is resolved by adding
the relation, or by adding the upstream item the item should hang from.

## Avoid

- 張り忘れ: names a cause, a relation left out, rather than the state. Write 接続漏れ.
- 未接続: a vaguer Japanese name for the same state. Write 接続漏れ.

## 定義

上流の item にぶら下がるべきなのに、向きが上流の relation を 1 本も張っていない item の状態。
sara はこの item を `Orphan item` として報告する。relation を張るか、ぶら下がるべき上流の item を
足して解消する。

## 避ける表現

- 張り忘れ: 状態ではなく、relation を張らなかったという原因を指す語。接続漏れと書く。
- 未接続: 同じ状態を指す、より曖昧な日本語名。接続漏れと書く。

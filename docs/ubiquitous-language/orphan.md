---
id: "UBQ-efc46003-0d42-4404-8f6f-e5a2691a326e"
type: ubiquitous_term
name: "orphan"
description: "上流の item にぶら下がるべきなのに、向きが上流の relation を 1 本も張っていない item。"
name_ja: "接続漏れ"
avoid:
  - "張り忘れ"
  - "未接続"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
---
# orphan

## Definition

An item that should hang from an upstream item but declares no relation whose direction is
upstream. sara reports such an item as `Orphan item`. An orphan is resolved by adding the
relation, or by adding the upstream item it should hang from.

## Avoid

- 張り忘れ: names a cause, a relation left out, rather than the state. Write 接続漏れ.
- 未接続: a vaguer Japanese name for the same state. Write 接続漏れ.

## 定義

上流の item にぶら下がるべきなのに、向きが上流の relation を 1 本も張っていない item。sara は
これを `Orphan item` として報告する。relation を張るか、ぶら下がるべき上流の item を足して
解消する。

## 避ける表現

- 張り忘れ: 状態ではなく、relation を張らなかったという原因を指す語。接続漏れと書く。
- 未接続: 同じ状態を指す、より曖昧な日本語名。接続漏れと書く。

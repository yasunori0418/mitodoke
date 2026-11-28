---
id: "UBQ-3cd3f93e-9cb4-4bde-a37c-229fe40479b4"
type: ubiquitous_term
name: "upstream"
description: "ある item が向きが上流の relation で指し、前提にしている item。"
name_ja: "上流"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:20:38+09:00"
---
# upstream

## Definition

Relative to an item, the items it points to through relations whose direction is upstream.
An upstream item states what the item takes as given, such as the requirement a design
realizes or the risk a test condition reduces. When an upstream item changes, the item can
become stale; whether its content must change is judged by a person.

## 定義

ある item から見て、向きが上流の relation で指している item。上流の item は、設計が実現する
要件や、テスト条件が減らすリスクのように、その item が前提にすることを述べる。上流の item が
変わると、その item は再確認待ちになりうる。内容を変える必要があるかは人間が判断する。

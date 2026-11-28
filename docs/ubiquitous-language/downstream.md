---
id: "UBQ-de39fa02-52b5-49b4-9d26-56af2ea70e2c"
type: ubiquitous_term
name: "downstream"
description: "ある item を向きが上流の relation で指し、その内容を前提にしている item。"
name_ja: "下流"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:17:55+09:00"
---
# downstream

## Definition

Relative to an item, the items that point to it through relations whose direction is
upstream. A downstream item builds on what the item states, such as a design built on a
requirement or a test case built on a test condition. A change upstream can make a downstream
item stale, which means that its judgment needs checking again, not that it must change.

## 定義

ある item から見て、それを向きが上流の relation で指している item。下流の item は、要件の上に
立つ設計や、テスト条件の上に立つテストケースのように、その item が述べることを前提にする。
上流の変更で下流の item は再確認待ちになりうる。それは下流の判断を確認し直す必要を意味し、
内容を変える必要を意味しない。

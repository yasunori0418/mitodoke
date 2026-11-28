---
id: "UBQ-90ca0aa7-b1bb-4f66-a1b6-55e3416776a4"
type: ubiquitous_term
name: "generated"
description: "item を最後に生成・更新した者と時刻を記録する frontmatter のプロパティ。"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:20+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:12+09:00"
---
# generated

## Definition

The frontmatter property that records who last generated or updated an item (`by`) and
when (`at`). Its `at` is the starting point of the item's reference time. When an item's
body changes, `generated` is updated with it; an item whose body changed while its
`generated.at` did not is enumerated as missing a `generated` update.

## 定義

item を最後に生成・更新した者（`by`）と時刻（`at`）を記録する frontmatter のプロパティ。
`at` は item の基準時刻の起点になる。item の本文を変えたら `generated` も更新する。本文が
変わったのに `generated.at` が変わっていない item は、`generated` の更新漏れとして列挙される。

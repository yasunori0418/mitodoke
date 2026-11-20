---
id: "UBQ-61190a98-4187-4cd7-ba7b-4cab614c2744"
type: ubiquitous_term
name: "reference time"
description: "item の鮮度を比べる基準にする、generated と verified から決まる時刻。"
name_ja: "基準時刻"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:20+09:00"
---
# reference time

## Definition

The time against which an item's freshness is compared: the latest of its `generated.at`
and the `verified[].at` values at or after `generated.at`, whoever the checker is. When an
upstream item's `generated.at` is later than an item's reference time, the item can become
stale.

## 定義

item の鮮度を比べる基準にする時刻。その item の `generated.at` と、`generated.at` 以降の
`verified[].at`（確認したのが誰かを問わない）のうち最も新しい時刻とする。上流の item の
`generated.at` がこの時刻より新しいとき、その item は再確認待ちになりうる。

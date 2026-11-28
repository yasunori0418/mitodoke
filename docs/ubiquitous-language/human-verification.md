---
id: "UBQ-b7742692-d339-43a7-95cb-652c8fb9413d"
type: ubiquitous_term
name: "human verification"
description: "人が item の内容を確かめたことの記録で、`verified` の要素のうち、`by` が `human:` で始まり、`at` がその item の `generated.at` 以降のもの。"
name_ja: "人の確認"
section: freshness
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:16+09:00"
---
# human verification

## Definition

A person's check of an item's content, recorded as an element of `verified` whose `by`
begins with `human:` and whose `at` is at or after the item's `generated.at`. An element
by any other actor advances the item's reference time but does not count as a human
verification, and neither does an element dated before `generated.at`. A human
verification records the act of checking, not a judgment that the item is correct.

## 定義

人が item の内容を確かめたことの記録で、`verified` の要素のうち、`by` が `human:` で始まり、
`at` がその item の `generated.at` 以降のもの。`human:` 以外の要素は item の基準時刻を進める
が、人の確認には数えない。`generated.at` より前の要素も数えない。人の確認は確かめた行為の記
録で、item が正しいという判定ではない。

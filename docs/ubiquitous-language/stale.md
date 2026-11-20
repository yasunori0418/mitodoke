---
id: "UBQ-874ba4fa-b95e-43f5-873a-f37a581f0aee"
type: ubiquitous_term
name: "stale"
description: "上流の item が自身の基準時刻より新しくなり、読み直しを待っている item の状態。"
name_ja: "再確認待ち"
avoid:
  - "再検証待ち"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:20+09:00"
---
# stale

## Definition

The state of an item when an upstream item's `generated.at` is later than the item's
reference time, so that it waits to be read again in light of the upstream change.
`justifies` and peer relations are not followed, and an item whose `status` is
`deprecated` is left out on either end. Being stale does not mean anything is broken: the
item is reported, and a person judges whether it needs to change.

## Avoid

- 再検証待ち: an earlier Japanese name for the same state. Write 再確認待ち.

## 定義

上流の item の `generated.at` が自身の基準時刻より新しくなり、上流の変更を踏まえた読み直しを
待っている item の状態。`justifies` と peer の relation は辿らず、`status` が `deprecated` の
item は両端のどちらでも除く。再確認待ちは何かが壊れたことを意味しない。item は報告され、
変える必要があるかは人間が判断する。

## 避ける表現

- 再検証待ち: 同じ状態を指す以前の日本語名。再確認待ちと書く。

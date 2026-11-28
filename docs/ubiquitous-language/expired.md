---
id: "UBQ-1f9f164c-ac04-4282-a8bc-58d6d6db54b5"
type: ubiquitous_term
name: "expired"
description: "item の `stale_after` の時刻を過ぎた状態。"
name_ja: "期限切れ"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:02+09:00"
---
# expired

## Definition

The state of an item whose `stale_after` time has passed. It differs from being
[stale](stale.md), which an upstream change causes: an item becomes expired by the passage
of time alone. An expired item is cleared only when a person rewrites `stale_after` to a
later time. Extending the deadline takes both a
[human verification](human-verification.md) and the rewrite of `stale_after`. A
`solution` item requires `stale_after`, and the interval up to that time has an upper
limit.

## 定義

item の `stale_after` の時刻を過ぎた状態。上流の変更で生じる[再確認待ち](stale.md)とは別の
状態で、時間の経過だけで生じる。期限切れが解けるのは、人が `stale_after` を先の時刻に書き換えた
ときだけである。期限を延ばすには、[人の確認](human-verification.md)の記録と `stale_after` の
書き換えの両方が要る。
`solution` は `stale_after` を必須とし、期限までの間隔に上限を持つ。

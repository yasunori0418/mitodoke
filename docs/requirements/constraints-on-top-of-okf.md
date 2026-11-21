---
id: "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
type: requirement
name: "OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する"
description: "OKF v0.2 の定義に重ねて、verified をリストに限るなど 5 つの制約を構造の契約として検査する。"
specification: |
  On top of the OKF v0.2 definitions, the following constraints SHALL be inspected as
  structural contracts. `verified` SHALL be a list, and a single mapping SHALL be a
  violation. Every item SHALL carry `generated`, and `generated.at` SHALL NOT be in the
  future. A newly created item SHALL carry `description`. An item of every type SHALL carry
  `status`. Only `verified` entries whose `at` is at or after `generated.at` SHALL count as
  human verifications.
specification_ja: |
  OKF v0.2 の定義に重ねて、次の制約を構造の契約として検査しなければならない。`verified` は
  リストでなければならず、1 つの mapping は違反としなければならない。すべての item は
  `generated` を持たなければならず、`generated.at` を未来の時刻にしてはならない。新しく
  起こす item は `description` を持たなければならない。すべての型の item は `status` を
  持たなければならない。人の確認として数えるのは、`at` が `generated.at` 以降の `verified`
  の要素だけでなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:36+09:00"
---
# OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する

## 仕様

OKF v0.2 の定義に従っているかの検査に重ねて、次の 5 つを構造の契約として検査する。

- `verified` はリストに限る。1 つの mapping は違反にする
- `generated` はすべての item で必須にし、`generated.at` に未来の時刻を書くことを禁じる
- 新しく起こす item では `description` を必須にする
- `status` はすべての型で必須にする
- 人の確認として数えるのは、`generated.at` 以降の `verified` だけにする

1 つの mapping の `verified` を 1 要素のリストとして読む OKF v0.2 の読み手の義務には沿わない。

## 出典

根拠の決定は次の ADR が持つ。

- [OKF より厳しい 5 つの制約を構造の契約に引き継ぐ](../adr/stricter-than-okf-constraints-kept.md)

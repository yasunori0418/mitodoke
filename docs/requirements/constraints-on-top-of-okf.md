---
id: "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
type: requirement
name: "OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する"
description: "OKF v0.2 の定義に重ねた 5 つの制約を持ち、verified の形・generated・status を構造の契約として検査し、description の欠けは mitodoke new が起票で拒み、人の確認は generated.at 以降の verified だけを数える。"
specification: |
  On top of the OKF v0.2 definitions, the following constraints SHALL be inspected as
  structural contracts. `verified` SHALL be a list, and a single mapping SHALL be a
  violation. Every item SHALL carry `generated`, and `generated.at` SHALL NOT be in the
  future. An item of every type SHALL carry `status`. mitodoke new SHALL refuse to create an
  item without `description`, and mitodoke check SHALL NOT treat the lack of `description` on
  an existing item as a violation. As a counting rule, only `verified` entries whose `at` is at
  or after `generated.at` SHALL count as human verifications, and a `verified` entry whose `at`
  is before `generated.at` SHALL NOT be treated as a violation.
specification_ja: |
  OKF v0.2 の定義に重ねて、次の制約を構造の契約として検査しなければならない。`verified` は
  リストでなければならず、1 つの mapping は違反としなければならない。すべての item は
  `generated` を持たなければならず、`generated.at` を未来の時刻にしてはならない。すべての型の
  item は `status` を持たなければならない。mitodoke new は `description` の無い起票を拒まなければ
  ならず、mitodoke check は既存の item の `description` の欠けを違反にしてはならない。数え方の規則
  として、人の確認として数えるのは、`at` が `generated.at` 以降の `verified` の要素だけでなければ
  ならず、`at` が `generated.at` より前の `verified` の要素があっても違反にしてはならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:53:45+09:00"
---
# OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する

## 仕様

OKF v0.2 の定義に従っているかの検査に重ねて、次の 5 つの制約を持つ。

- `verified` はリストに限る。1 つの mapping は構造の契約の違反にする
- `generated` はすべての item で必須にし、`generated.at` に未来の時刻を書くことを禁じる。構造の契約として検査する
- `description` は、`mitodoke new` が `description` の無い起票を拒むことで必須にする。`mitodoke check` は、既存の item の `description` の欠けを違反にしない
- `status` はすべての型で必須にする。構造の契約として検査する
- 人の確認として数えるのは、`at` が `generated.at` 以降の `verified` の要素だけにする。これは数え方の規則で、`at` が `generated.at` より前の `verified` の要素があっても違反にしない

1 つの mapping の `verified` を 1 要素のリストとして読む OKF v0.2 の読み手の義務には沿わない。

## 出典

根拠の決定は次の ADR が持つ。

- [OKF より厳しい 5 つの制約を引き継ぎ、description は起票で拒み、verified の数え方は違反の条件にしない](../adr/stricter-than-okf-constraints-and-inspection-points.md)

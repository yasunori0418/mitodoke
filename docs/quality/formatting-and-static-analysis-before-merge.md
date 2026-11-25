---
id: "QA-1b6075e4-bb76-4da5-86a3-72e7486d7997"
type: quality
name: "rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする"
description: "整形の rustfmt と静的解析の clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにすると定める。"
specification: "The project SHALL include rustfmt and clippy in the verification that a change passes before it is merged, and SHALL make the same results obtainable on a developer's machine."
specification_ja: "rustfmt と clippy をマージ前の検証に入れなければならず、手元でも同じ判定を得られるようにしなければならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:32:09+09:00"
---
# rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする

## 仕様

整形の rustfmt と静的解析の clippy を、変更をマージする前の検証に入れる。手元でも、マージ前の検証と
同じ判定を得られるようにする。

## 出典

根拠の決定は次の ADR が持つ。

- [rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする](../adr/rustfmt-and-clippy-gate-merges.md)

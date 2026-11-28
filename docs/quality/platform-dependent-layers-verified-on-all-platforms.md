---
id: "QA-b1f0d6f5-3d96-4d3f-9378-5ad23f27249a"
type: quality
name: "プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる"
description: "プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させると定める。"
specification: "For the layers where platforms differ, verification SHALL succeed on every platform that mitodoke is distributed for before a change is merged."
specification_ja: "プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させなければならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:35:10+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:15:45+09:00"
---
# プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる

## 仕様

プラットフォームの差が出る層は、変更をマージする前に、配布の対象のすべてのプラットフォームで検証を
成功させる。どれか 1 つのプラットフォームで検証が成功していなければ、マージしない。

## 出典

根拠の決定は次の ADR が持つ。

- [プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる](../adr/all-platforms-verified-before-merge.md)

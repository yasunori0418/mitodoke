---
id: "QA-febe2e03-f845-40c2-8359-8ebaefb71ddd"
type: quality
name: "文書管理の規範と決定は mitodoke のリポジトリで変える"
description: "写した時点から、文書管理の規範と決定を mitodoke のリポジトリだけで変えることを定める。"
specification: "From the point at which they were copied from layat (97ec53ae), the document-management norms and decisions SHALL be changed only in the mitodoke repository. A change noticed while working on layat SHALL be filed as a mitodoke issue and then made in mitodoke. The source documents in layat SHALL NOT be changed until layat migrates to mitodoke."
specification_ja: "layat から写した時点（97ec53ae）から、文書管理の規範と決定は mitodoke のリポジトリだけで変えなければならない。layat の作業中に気づいた変更も、mitodoke の Issue に起票してから mitodoke で変えなければならない。layat のコピー元の文書は、layat が mitodoke へ移行するまで変えてはならない。"
status: stable
infrastructure_exempt: "別のリポジトリで行われた変更は、このリポジトリの仕組みからは見えない。"
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:25:06+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:16:23+09:00"
---
# 文書管理の規範と決定は mitodoke のリポジトリで変える

## 仕様

文書管理の規範と決定は、layat から写した時点（layat の `97ec53ae`）から、mitodoke のリポジトリ
だけで変える。

- layat の作業中に、文書管理の規範や決定を変えたくなったときも、mitodoke の Issue に起票してから
  mitodoke で変える
- layat のコピー元の文書は、layat が mitodoke へ移行するまで変えない

## 出典

根拠の決定は次の ADR が持つ。

- [文書管理の規範と決定は、写した時点から mitodoke だけで変える](../adr/norms-changed-only-in-mitodoke-after-copy.md)

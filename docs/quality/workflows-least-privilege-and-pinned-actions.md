---
id: "QA-8f4da12f-6ce7-4d78-9b59-fb67891e8f71"
type: quality
name: "workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する"
description: "workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定すると定める。"
specification: "Every workflow SHALL declare least-privilege `permissions`, and every external action SHALL be pinned to a commit SHA."
specification_ja: "workflow は最小権限の `permissions` を宣言しなければならず、外部の action はコミット SHA で固定しなければならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:37:28+09:00"
---
# workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する

## 仕様

workflow は最小権限の `permissions` を宣言する。workflow が使う外部の action は、コミット SHA で
固定する。

## 出典

根拠の決定は次の ADR が持つ。

- [workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する](../adr/least-privilege-workflows-and-pinned-actions.md)

---
id: "QA-4643187c-702a-4d53-9efe-b8352938d6d7"
type: quality
name: "カバレッジは報告にとどめ、閾値でマージを止めない"
description: "カバレッジは報告にとどめ、閾値でマージを止めないと定める。"
specification: "The project SHALL limit code coverage to reporting, and SHALL NOT block a merge with a coverage threshold."
specification_ja: "カバレッジは報告にとどめなければならず、閾値でマージを止めてはならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:34:06+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:10:17+09:00"
---
# カバレッジは報告にとどめ、閾値でマージを止めない

## 仕様

カバレッジは計測して報告するだけにする。カバレッジの閾値を決めて、それを下回る変更のマージを止める
ことはしない。

## 出典

根拠の決定は次の ADR が持つ。

- [カバレッジは報告にとどめ、閾値でマージを止めない](../adr/coverage-is-reported-not-gated.md)

---
id: "QA-8ec88967-57ce-40aa-957d-ff3c640a44b2"
type: quality
name: "main は PR だけで変え、required の check が成功するまでマージしない"
description: "main は PR だけで変え、required の check が成功するまでマージせず、直接の push、削除、force push を禁じると定める。"
specification: "main SHALL be changed only through pull requests, and a pull request SHALL NOT be merged until the required checks succeed. Direct pushes to main, deletion of main, and force pushes to main SHALL be prohibited."
specification_ja: "main は PR だけで変えなければならず、required の check が成功するまでマージしてはならない。main への直接の push、main の削除、main への force push を禁じなければならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:35:56+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:13:41+09:00"
---
# main は PR だけで変え、required の check が成功するまでマージしない

## 仕様

main は PR だけで変える。PR は required の check が成功するまでマージしない。

main への直接の push、main の削除、main への force push を禁じる。

## 出典

根拠の決定は次の ADR が持つ。

- [main は PR だけで変え、required の check が成功するまでマージしない](../adr/main-protected-by-required-checks.md)

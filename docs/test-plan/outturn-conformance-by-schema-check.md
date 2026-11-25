---
id: "TP-2d0beccd-8660-4804-8637-4c4e83736efe"
type: test_plan
name: "outturn への適合は受け入れテストで --json の出力のサンプルを schema に照らして確かめる"
description: "outturn への適合を受け入れテストの範囲に入れ、mitodoke の --json の出力のサンプルを outturn の flake の lib.mkSchemaCheck で確かめ、item の id の導出は確かめない。"
specification: |
  The test process SHALL include conformance to outturn in the scope of the acceptance tests. The
  acceptance tests SHALL check samples of the --json output of mitodoke against the schema with
  lib.mkSchemaCheck of the outturn flake. The test process SHALL NOT check the derivation of item
  ids in mitodoke.
specification_ja: |
  テストプロセスは outturn への適合を受け入れテストの範囲に入れなければならない。受け入れテストは
  mitodoke の --json の出力のサンプルを、outturn の flake の lib.mkSchemaCheck で schema に照らして
  確かめなければならない。テストプロセスは item の id の導出を mitodoke で確かめてはならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:08:29+09:00"
---
# outturn への適合は受け入れテストで --json の出力のサンプルを schema に照らして確かめる

## 仕様

outturn への適合は受け入れテストの範囲に入れる。`mitodoke` の `--json` の出力のサンプルを、outturn の
flake の `lib.mkSchemaCheck` で schema に照らして確かめる。

item の `id` の導出は outturn の crate のテストが持つので、mitodoke では確かめない。

## 出典

根拠の決定は次の ADR が持つ。

- [outturn への適合は、--json の出力のサンプルを schema で確かめる](../adr/outturn-conformance-checked-by-schema.md)

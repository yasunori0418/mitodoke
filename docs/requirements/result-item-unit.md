---
id: "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
type: requirement
name: "check・gap・fresh の item は契約と文書の組を単位とする"
description: "check・gap・fresh の結果エンベロープは、1 つの文書が 1 つの契約に反したことを item 1 つで表し、成り立った組は item にしない。"
specification: |
  In the result envelopes of check, gap and fresh, mitodoke SHALL represent each case in which
  one document violates one contract (for gap and fresh, each case in which one document falls
  under one section) as one item. The kind of the item SHALL be the name of the contract and its
  key SHALL be the ID of the document. This requirement does not specify how a pair that has
  only findings at report strength is represented. mitodoke SHALL NOT emit an item for a pair of
  a contract and a document that holds.
specification_ja: |
  check・gap・fresh の結果エンベロープでは、mitodoke は、1 つの文書が 1 つの契約に反したこと
  （gap と fresh では、1 つの文書が 1 つの節に該当したこと）を、item 1 つで表さなければならない。
  item の kind は契約の名前で、key は文書の ID でなければならない。報告の強さの指摘だけを持つ
  組の表し方は、この要求では定めない。mitodoke は、成り立った契約と文書の組を item にしては
  ならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T17:06:53+09:00"
---
# check・gap・fresh の item は契約と文書の組を単位とする

## 仕様

`check`・`gap`・`fresh` は、検査の結果を、契約と文書の組を単位とする item で表す。1 つの文書が
1 つの契約に反したこと（`gap` と `fresh` では、1 つの文書が 1 つの節に該当したこと）が、item
1 つになる。item の `kind` は契約の名前、`key` は文書の ID である。

成り立った組は item にしない。報告の強さの指摘だけを持つ組の表し方は、この要求では定めない。

## 出典

根拠の決定は次の ADR が持つ。

- [check・gap・fresh の item を契約 × 文書の単位にする](../adr/result-items-per-contract-and-document.md)

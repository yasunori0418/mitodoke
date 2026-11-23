---
id: "REQ-fe865691-be47-4ddf-b878-01fc88c0a549"
type: requirement
name: "検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける"
description: "組み込みの型・relation・フィールドの名前を条件に持つ契約は組み込みの型の item だけに、それ以外の契約は独自の型を含むすべての型の item に働かせる。"
specification: |
  mitodoke SHALL apply a contract whose condition refers to the name of a built-in type, a
  built-in relation, or a built-in field only to items of the built-in types. mitodoke SHALL
  apply every other contract to items of every type, including custom types.
specification_ja: |
  mitodoke は、組み込みの型・relation・フィールドの名前を条件に持つ契約を、組み込みの型の item だけに
  働かせなければならない。mitodoke は、それ以外の契約を、独自の型を含むすべての型の item に働かせ
  なければならない。
section: model-config
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:52:12+09:00"
---
# 検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける

## 仕様

mitodoke の検査は、独自の型の item に及ぶかどうかで次の 2 つに分ける。

- 組み込みの型だけに働かせる: 組み込みの型・relation・フィールドの名前を条件に持つ契約
- 独自の型を含むすべての型に働かせる: それ以外の契約

## 出典

根拠の決定は次の ADR が持つ。

- [組み込みの型・relation・フィールドの名前を条件に持つ契約を、組み込みの型の item だけに働かせる](../adr/builtin-only-contracts-closed-by-rule.md)

---
id: "REQ-fe865691-be47-4ddf-b878-01fc88c0a549"
type: requirement
name: "検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける"
description: "frontmatter の形・ID の置き場所・index.md の生成と差分はすべての型に、型に固有の契約は組み込みの型だけに働かせる。"
specification: |
  mitodoke SHALL apply the inspections of the frontmatter shape (`generated` and
  `verified`), the placement of IDs, and the generation of index.md and its difference to
  items of every type, including custom types. mitodoke SHALL apply type-specific contracts,
  such as the detection of missing connections, the derivation of a risk's level, and the
  one-to-one correspondence between test cases and test assets, only to items of the built-in
  types.
specification_ja: |
  mitodoke は、frontmatter の形（`generated` と `verified`）、ID の置き場所、index.md の生成と
  差分の検査を、独自の型を含むすべての型の item に働かせなければならない。mitodoke は、つながりの
  欠けの判定、risk の level の導出、test_case とテスト資産の 1:1 など、型に固有の契約を、組み込みの
  型の item だけに働かせなければならない。
section: model-config
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:03+09:00"
---
# 検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける

## 仕様

mitodoke の検査は、独自の型の item に及ぶかどうかで次の 2 つに分ける。

- すべての型に働かせる: frontmatter の形（`generated` と `verified`）、ID の置き場所、
  index.md の生成と差分
- 組み込みの型だけに働かせる: つながりの欠けの判定、risk の level の導出、test_case とテスト資産の
  1:1 など、型に固有の契約

## 出典

根拠の決定は次の ADR が持つ。

- [型に固有の契約は組み込みの型だけに働かせる](../adr/type-specific-contracts-builtin-only.md)

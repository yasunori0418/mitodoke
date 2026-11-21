---
id: "REQ-ade865fa-90ea-43c3-b504-4566bb9582ae"
type: requirement
name: "specification は英語で必須とし、ほかの言語のフィールドは設定から生成する"
description: "specification は英語で必須とし、設定で選んだほかの言語ごとに specification_<言語> と name_<言語> のフィールドを生成する。"
specification: |
  The `specification` field of requirement, quality and test_plan items SHALL be required and
  SHALL be written in English. The configuration file SHALL allow selecting additional
  languages, and for each selected language mitodoke SHALL generate the fields
  `specification_<language>` and `name_<language>` into the model.
specification_ja: |
  requirement・quality・test_plan の item の `specification` フィールドは必須でなければならず、
  英語で書かなければならない。設定ファイルはほかの言語を選べなければならず、mitodoke は選んだ
  言語ごとに `specification_<言語>` と `name_<言語>` のフィールドをモデルへ生成しなければならない。
section: model-config
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:31:29+09:00"
---
# specification は英語で必須とし、ほかの言語のフィールドは設定から生成する

## 仕様

- requirement・quality・test_plan の `specification` は必須で、英語で書く
- ほかの言語は設定ファイルで選ぶ。mitodoke は、選んだ言語ごとに `specification_<言語>` と
  `name_<言語>` のフィールドをモデルへ生成する

## 出典

根拠の決定は次の ADR が持つ。

- [specification は英語で必須にし、ほかの言語は設定で選ぶ](../adr/specification-english-required-other-languages-configured.md)

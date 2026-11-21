---
id: "REQ-01efc4d0-bec2-44d7-8592-0f7adc81a236"
type: requirement
name: "組み込みの型は 12 型で、すべて必須とする"
description: "製品の組み込みの型は 12 型とし、どの適用先の製品でもすべてを持ち、設定で選ばない。"
specification: |
  The built-in types of mitodoke SHALL be the following twelve types: `solution`,
  `use_case`, `requirement`, `design`, `risk`, `test_condition`, `test_plan`, `test_case`,
  `quality`, `infrastructure`, `adr`, and `ubiquitous_term`. The model generated for every
  adopting product SHALL include all twelve built-in types, and the configuration file SHALL
  NOT provide a means to select or omit built-in types.
specification_ja: |
  mitodoke の組み込みの型は、`solution`・`use_case`・`requirement`・`design`・`risk`・
  `test_condition`・`test_plan`・`test_case`・`quality`・`infrastructure`・`adr`・
  `ubiquitous_term` の 12 型でなければならない。どの適用先の製品に生成する model も、組み込みの
  12 型をすべて含まなければならず、設定ファイルは組み込みの型を選ぶ手段も外す手段も持っては
  ならない。
section: model-config
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:03+09:00"
---
# 組み込みの型は 12 型で、すべて必須とする

## 仕様

mitodoke の組み込みの型は、次の 12 型とする。どの適用先の製品に生成する model も、12 型を
すべて含む。

- `solution`・`use_case`・`requirement`・`design`
- `risk`・`test_condition`・`test_plan`・`test_case`
- `quality`・`infrastructure`・`adr`・`ubiquitous_term`

適用先の製品は、設定で使う型を選ばない。文書管理の決定を記録する専用の型（`sara_adr`）は
組み込みの型に含めず、文書管理の決定も `adr` に記録する。

## 出典

根拠の決定は次の ADR が持つ。

- [組み込みの型を 12 型にし、すべて必須にする](../adr/twelve-builtin-types-all-required.md)

---
id: "UBQ-5eea3836-4488-4697-aec5-764db3ae992e"
type: ubiquitous_term
name: "built-in type"
description: "どの製品のモデルにも最初から含まれる 12 の型の 1 つ。"
name_ja: "組み込みの型"
section: model-types
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:17:40+09:00"
---
# built-in type

## Definition

One of the twelve types of the model that every product has from the start: `solution`,
`use_case`, `requirement`, `design`, `risk`, `test_condition`, `test_plan`, `test_case`,
`quality`, `infrastructure`, `adr` and `ubiquitous_term`. A product does not choose
which of them to use, and configuration can neither remove nor change a built-in type or
its relations and fields. Contracts specific to a type work only on built-in types.

## 定義

どの製品のモデルにも最初から含まれる 12 の型の 1 つ。`solution`・`use_case`・`requirement`・
`design`・`risk`・`test_condition`・`test_plan`・`test_case`・`quality`・`infrastructure`・
`adr`・`ubiquitous_term` がある。製品は使う型を選ばず、組み込みの型とその relation・
フィールドは、設定で削除も変更もできない。型に固有の契約は、組み込みの型だけに働く。

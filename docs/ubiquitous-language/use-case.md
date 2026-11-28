---
id: "UBQ-f36339f2-3d0d-43e5-917c-91a67fe8082a"
type: ubiquitous_term
name: "use_case"
description: "利用者が製品で何をしたいかを述べるモデルの型。"
name_ja: "要求"
avoid:
  - "UseCase"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:20:41+09:00"
---
# use_case

## Definition

A model type that states what a user wants to do with the product. A requirement, in
contrast, states the conditions the product meets to answer it. Its fields and the
relations it can carry are defined in `docs/model.yaml`. Its ID prefix UC may be used as a
short name.

## Avoid

- `UseCase`: a PascalCase type name. Write `use_case` as the identifier.

## 定義

利用者が製品で何をしたいかを述べるモデルの型。これに対して要件は、それに応えるために製品が
満たす条件を述べる。フィールドと張れる relation は `docs/model.yaml` が定義する。ID の prefix の
UC を略記として使ってよい。

## 避ける表現

- `UseCase`: PascalCase の型名。識別子は `use_case` と書く。

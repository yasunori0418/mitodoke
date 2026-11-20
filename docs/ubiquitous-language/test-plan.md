---
id: "UBQ-df304c7e-84e8-4909-89a3-33e6b632542b"
type: ubiquitous_term
name: "test_plan"
description: "テスト計画の活動で決めたことを述べるモデルの型。"
name_ja: "テスト計画"
avoid:
  - "TestPlan"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
---
# test_plan

## Definition

A model type that states what test planning decided: the scope of testing and what is out
of scope, the test levels, the test approach, and what testability the product needs. Its
fields and the relations it can carry are defined in `docs/model.yaml`. Its ID prefix TP
may be used as a short name.

## Avoid

- `TestPlan`: a PascalCase type name. Write `test_plan` as the identifier.

## 定義

テスト計画の活動で決めたこと（テストの範囲と範囲外、テストレベル、テストのアプローチ、製品に
求めるテスト容易性）を述べるモデルの型。フィールドと張れる relation は `docs/model.yaml` が
定義する。ID の prefix の TP を略記として使ってよい。

## 避ける表現

- `TestPlan`: PascalCase の型名。識別子は `test_plan` と書く。

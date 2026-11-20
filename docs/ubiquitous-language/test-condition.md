---
id: "UBQ-e60261a5-0713-4a46-a3f0-6c1015a11df7"
type: ubiquitous_term
name: "test_condition"
description: "リスクを減らすためにテストが検証するテーマ 1 つを表すモデルの型。"
name_ja: "テスト条件"
avoid:
  - "TestCondition"
  - "テスト観点"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:37:56+09:00"
---
# test_condition

## Definition

A model type that records one theme a test verifies in order to reduce a risk. A test
condition is raised per verification theme, so one risk bundles several test conditions,
and test cases cover each test condition. Its fields and the relations it can carry are
defined in `docs/model.yaml`. Its ID prefix TC may be used as a short name.

## Avoid

- `TestCondition`: a PascalCase type name. Write `test_condition` as the identifier.
- テスト観点: another Japanese name for the same type. Write テスト条件.

## 定義

リスクを減らすためにテストが検証するテーマ 1 つを記録するモデルの型。テスト条件は検証テーマ
ごとに起こすので、1 つのリスクは複数のテスト条件を束ね、各テスト条件はテストケースが
カバーする。フィールドと張れる relation は `docs/model.yaml` が定義する。ID の prefix の TC を
略記として使ってよい。

## 避ける表現

- `TestCondition`: PascalCase の型名。識別子は `test_condition` と書く。
- テスト観点: 同じ型を指す別の日本語名。テスト条件と書く。

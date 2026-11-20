---
id: "UBQ-2653c4dd-791d-4148-8b31-e027bff99a51"
type: ubiquitous_term
name: "test_case"
description: "単独で実行できるテスト 1 つを表すモデルの型。"
name_ja: "テストケース"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
---
# test_case

## Definition

A model type that represents one test asset, such as a test file or a test scenario that
runs on its own. A test case is raised per test asset, covers test conditions, and follows
a test plan. Its fields and the relations it can carry are defined in `docs/model.yaml`.
Its ID prefix CASE may be used as a short name.

## 定義

テストファイルやテストシナリオのような、単独で実行できるテスト資産 1 つを表すモデルの型。
テストケースはテスト資産ごとに起こし、テスト条件をカバーし、テスト計画に従う。フィールドと
張れる relation は `docs/model.yaml` が定義する。ID の prefix の CASE を略記として使ってよい。

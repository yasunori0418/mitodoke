---
id: "UBQ-2653c4dd-791d-4148-8b31-e027bff99a51"
type: ubiquitous_term
name: "test_case"
description: "テスト資産 1 つに対応するテストを表すモデルの型。"
name_ja: "テストケース"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:36:33+09:00"
---
# test_case

## Definition

A model type that represents one test corresponding to one test asset, such as a test
file, a test scenario, or a procedure or test charter that a person follows. A test case
is raised per test asset. A test that a person performs is also raised as a test case,
and its `resource` points to the procedure or test charter file. A test that a person
performs still requires `covers` and `follows`. Its fields and the relations it can carry
are defined in `docs/model.yaml`. Its ID prefix CASE may be used as a short name.

## 定義

テストファイル、テストシナリオ、人が従う手順書やテストチャーターのような、テスト資産 1 つに
対応するテストを表すモデルの型。テストケースはテスト資産ごとに起こす。人が行うテストも
テストケースとして起こし、`resource` で手順書かテストチャーターのファイルを指す。人が行う
テストでも、`covers` と `follows` は必須である。フィールドと張れる relation は
`docs/model.yaml` が定義する。ID の prefix の CASE を略記として使ってよい。

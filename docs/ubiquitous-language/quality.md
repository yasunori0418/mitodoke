---
id: "UBQ-af762fb2-e974-4c4a-a70d-e1679ee5f6c8"
type: ubiquitous_term
name: "quality"
description: "テストの工程の外にある、開発の進め方を縛る方針と規約を述べるモデルの型。"
name_ja: "品質"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
---
# quality

## Definition

A model type that states a policy or rule that binds how the product is developed, across
processes and outside the test process. Rules about planning tests belong to test plans
instead. Its fields and the relations it can carry are defined in `docs/model.yaml`. Its
ID prefix QA may be used as a short name.

## 定義

工程を横断して製品の開発の進め方を縛る方針や規約のうち、テストの工程の外にあるものを述べる
モデルの型。テストの計画に関する規約はテスト計画に置く。フィールドと張れる relation は
`docs/model.yaml` が定義する。ID の prefix の QA を略記として使ってよい。

---
id: "UBQ-88f15239-cdc1-46c4-867c-01c7ea37d78f"
type: ubiquitous_term
name: "solution"
description: "製品が何であるかを述べる、仕様の連鎖の根になるモデルの型。"
name_ja: "解決策"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
---
# solution

## Definition

A model type that states what the product built in the repository is. It is the root of
the chain that runs through use cases and requirements to designs, and qualities and test
plans also start from it. Its fields and the relations it can carry are defined in
`docs/model.yaml`. Its ID prefix SOL may be used as a short name.

## 定義

リポジトリが作る製品が何であるかを述べるモデルの型。要求・要件を経て設計へ続く連鎖の根で、
品質とテスト計画もここを起点にする。フィールドと張れる relation は `docs/model.yaml` が
定義する。ID の prefix の SOL を略記として使ってよい。

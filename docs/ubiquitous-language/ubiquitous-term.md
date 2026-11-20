---
id: "UBQ-6e62b97b-cbd0-462c-8503-767e112c9520"
type: ubiquitous_term
name: "ubiquitous_term"
description: "用語 1 語の正名と避ける綴りを固定するモデルの型。"
name_ja: "用語"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
---
# ubiquitous_term

## Definition

A model type that fixes the canonical English and Japanese names of one domain term, the
spellings to avoid, and its definition. Writing across the repository follows it. It is a
root that connects to no other item. Its fields and the relations it can carry are defined
in `docs/model.yaml`. Its ID prefix UBQ may be used as a short name.

## 定義

ドメインの用語 1 語について、英語と日本語の正名・避ける綴り・定義を固定するモデルの型。
リポジトリ全体の執筆はこれに従う。ほかのどの item ともつながない根になる。フィールドと
張れる relation は `docs/model.yaml` が定義する。ID の prefix の UBQ を略記として使ってよい。

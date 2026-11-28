---
id: "UBQ-a7ba36c2-ac01-4743-984a-06b44a789edb"
type: ubiquitous_term
name: "risk"
description: "要件や設計が満たされなくなる懸念を、脅威ごとに述べるモデルの型。"
name_ja: "リスク"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:19:44+09:00"
---
# risk

## Definition

A model type that states a concern that a requirement or a design may fail to hold. A risk
is raised per threat, and one risk bundles the test conditions that verify it. Its fields
and the relations it can carry are defined in `docs/model.yaml`. Its ID prefix RISK may be
used as a short name.

## 定義

要件や設計が満たされなくなる懸念を述べるモデルの型。リスクは脅威ごとに起こし、1 つのリスクは
それを検証するテスト条件を束ねる。フィールドと張れる relation は `docs/model.yaml` が定義する。
ID の prefix の RISK を略記として使ってよい。

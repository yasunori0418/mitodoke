---
id: "UBQ-ef39d17e-ce29-47d0-b608-212a6728aff2"
type: ubiquitous_term
name: "adr"
description: "1 つの意思決定とその背景・根拠を記録するモデルの型。"
section: model-types
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:39:05+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:17:30+09:00"
---
# adr

## Definition

A model type that records one decision together with its background, rationale, and the
alternatives it rejected. Its fields and the relations it can carry are defined in
`docs/model.yaml`. Its ID prefix ADR may be used as a short name.

## 定義

1 つの意思決定を、その背景・根拠・棄却した代替案とともに記録するモデルの型。フィールドと
張れる relation は `docs/model.yaml` が定義する。ID の prefix の ADR を略記として使ってよい。

---
id: "ADR-61974757-1fc4-46db-ae81-b3d6c37053e8"
type: adr
name: "model は型の関係図を出さず、型の関係図と model.yaml のずれも扱わない"
description: "mitodoke model は型の関係図を出さず、型の関係図と model.yaml のずれも扱わない。"
section: model-config
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 6 節（index・model）"
origin: "issue #72 の grilling（2026-11-22）で ADR に記録した。決定は 2026-11-17 の grilling で済んでいた"
justifies:
  - "REQ-76368939-a62b-47cb-b334-8bd7d7ee8389"
references:
  - "ADR-a8ba58e1-b92b-481a-b566-49d9b303dcd9"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:31:12+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:33+09:00"
---
# model は型の関係図を出さず、型の関係図と model.yaml のずれも扱わない

- ステータス: stable
- 日付: 2026-11-17
- 関連: [model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md), GitHub Issue #72, GitHub Issue #6
- 起点: issue #72 の grilling（2026-11-22）で ADR に記録した。決定は 2026-11-17 の grilling で済んでいた

## 背景

`mitodoke model` は、適用先の製品の model.yaml と sara.toml を設定ファイルから生成する
（[model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる](../requirements/model-and-sara-toml-generated-from-config.md)）。
このとき、型と relation の関係図も出すかが決まっていなかった。

layat では型の関係図と model.yaml がずれる問題が未解消のまま残っていた（`layat #650` の 4 つ目）。
型の関係図の生成は sara の upstream へ回していた（`layat #267`）。2026-11-17 の grilling で、
このずれを mitodoke では扱わないと決めたが、その決定は ADR に無かった。

## 決定

- `mitodoke model` は型の関係図を出さない
- 型の関係図と model.yaml のずれも、mitodoke では扱わない

## 根拠

2026-11-17 の grilling で、型の関係図と model.yaml のずれを mitodoke では扱わないと決めた。layat では型の関係図の
生成を sara の upstream へ回していた。

記録には、これより詳しい理由は無い。

## 棄却した代替案

### `mitodoke model` が model.yaml と一緒に型の関係図を出す

記録にはこの案に固有の不採用の理由は無い。型の関係図と model.yaml のずれを扱わないという
2026-11-17 の決定に合わせて、型の関係図を出さない形を選んだ。

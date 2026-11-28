---
id: "ADR-f2d8d15d-b62b-4a7a-ace0-d3a6fbeab30e"
type: adr
name: "設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする"
description: "設定ファイルは YAML の mitodoke.yaml とし、独自の型・relation・フィールドは sara の model.yaml と同じ書き方で書く。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q26）で確定"
justifies:
  - "REQ-26df91d3-8166-4192-9b78-7b4b82c306c8"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:14+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:23:56+09:00"
---
# 設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q26）で確定

## 背景

model.yaml は mitodoke の設定ファイルから生成すると決めた
（[model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md)）。
その設定ファイルの名前と形式を決める必要があった。

設定に書くもののうち、最も入れ子が深いのは独自の型の定義である。sara の model.yaml では、
`field_type: !enum` や `!list text` のように、YAML のタグでフィールドの型を書く。TOML には
タグが無い。一方で、sara の設定ファイル `sara.toml` と、Rust の `Cargo.toml` は TOML である。

## 決定

設定ファイルは YAML の `mitodoke.yaml` にする。独自の型・relation・フィールドは、sara の
model.yaml と同じ書き方（`!enum` などのタグを含む）で書ける。

mitodoke は、設定から model.yaml と sara.toml を生成してコミットし、差分が無いことを CI で
確かめる。

## 根拠

設定のうち最も複雑な独自の型の定義を、sara の model.yaml と同じ書き方で書ける。適用先の製品は
sara の README の例をそのまま写せて、mitodoke は書き方を別に決めて変換する必要がない。

sara.toml も生成するのは、sara の CLI が mitodoke と同じ model.yaml と走査の範囲を使うように
するためである。

## 棄却した代替案

### TOML の mitodoke.toml にし、独自の型などは mitodoke が決めた書き方で書く

sara.toml や Cargo.toml と形式が揃う利点はあるが、設定の中身は sara.toml よりも model.yaml に
近い。TOML にはタグが無いので、mitodoke がフィールドの型の書き方を別に決めて、model.yaml へ
写すことになる。

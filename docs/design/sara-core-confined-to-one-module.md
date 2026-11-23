---
id: "DSG-a5468c87-cf5a-4d27-b261-d22a083a6ff0"
type: design
name: "sara-core を使う箇所を 1 つのモジュールに集める"
description: "CLI は sara-core を crate として組み込み、sara-core を呼ぶ箇所を CLI の中の 1 つのモジュールに集める"
section: product-scope
status: stable
satisfies:
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:45:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-23T13:45:23+09:00"
---
# sara-core を使う箇所を 1 つのモジュールに集める

## 設計

CLI は Rust で書き、sara のライブラリ `sara-core` を crate として直接使う。sara の CLI を
subprocess で呼ばないので、CLI は sara を組み込んだ 1 つのバイナリになる。`sara-core` の
バージョンは Cargo.lock で固定する。

`sara-core` を呼ぶ箇所は、CLI の中の 1 つのモジュールに集める。ほかのモジュールは
`sara-core` を直接使わない。sara のバージョンを上げて API が変わったときの追随の範囲を、
このモジュールに集めて小さくする。

このモジュールは、別の検証エンジンへ差し替えるための抽象化ではない。

## 出典

根拠の決定は次の ADR が持つ。

- [Rust で書き、sara-core を crate として組み込む](../adr/rust-cli-embedding-sara-core.md)

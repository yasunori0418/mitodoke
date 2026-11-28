---
id: "ADR-15a504d6-9854-43c7-9edd-561e290e4539"
type: adr
name: "rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする"
description: "mitodoke 自身の開発で、rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-1b6075e4-bb76-4da5-86a3-72e7486d7997"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:47:19+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:40:51+09:00"
---
# rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI を実装する前に、mitodoke 自身の
開発の規範を決める必要があった。#6 のコメントは整形と静的解析をマージ前の検証に入れるかを、決まって
いない規範の候補に挙げていた。

## 決定

規範 [rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする](../quality/formatting-and-static-analysis-before-merge.md)
を起こす。rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする。

検証の job と、手元で流すコマンドは、この規範では決めない。CI を実装する
子の epic A（テストの区分の `foundation` に当たる範囲）が決める。

## 根拠

- 整形と静的解析の指摘を、レビューで人が拾わずに済む
- 手元と CI で判定が違うと、PR を出してから直す往復が増える
- 規範を先に書いておけば、子の epic は CI を実装するときに、何を満たせばよいかを item から読める

## 棄却した代替案

### CI だけで判定し、手元で同じ判定を得る手段を用意しない

手元と CI で判定が違うと、PR を出してから直す往復が増える。

### 指摘を警告にとどめ、マージを止めない

整形と静的解析の指摘が残ったまま main に入り、レビューで人が拾うことになる。

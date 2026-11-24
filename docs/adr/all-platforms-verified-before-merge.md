---
id: "ADR-5ac3c1b5-b8bc-4d3f-a9db-b4f7d3317e13"
type: adr
name: "プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる"
description: "mitodoke 自身の開発で、プラットフォームの差が出る層をマージ前に配布の対象のすべてのプラットフォームで検証する規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-b1f0d6f5-3d96-4d3f-9378-5ad23f27249a"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:47:19+09:00"
---
# プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI を実装する前に、mitodoke 自身の
開発の規範を決める必要があった。#6 のコメントはプラットフォームごとの検証を、決まっていない規範の候補に
挙げていた。

## 決定

規範 [プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる](../quality/platform-dependent-layers-verified-on-all-platforms.md)
を起こす。プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を
成功させる。

対象のプラットフォームの一覧と job の行列は、この規範では決めない。
子の epic A（テストの区分の `foundation` に当たる範囲）と、
子の epic G（テストの区分の `distribution` に当たる範囲）が決める。

## 根拠

- 配布の対象で動かない変更を main に入れない
- main に入ってから見つかると、原因の変更を探す範囲が広がる
- 規範を先に書いておけば、子の epic は CI を実装するときに、何を満たせばよいかを item から読める

## 棄却した代替案

### main に入ったあとで全プラットフォームを検証する

全プラットフォームでの検証を、main に入ったあとで行う案。main に入ってから見つかると、原因の変更を
探す範囲が広がる。

### 1 つのプラットフォームだけで検証する

配布の対象のうち 1 つのプラットフォームだけで検証する案。ほかの配布の対象で動かない変更が main に
入る。

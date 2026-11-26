---
id: "ADR-3725e632-122c-485b-9432-4eb3dce3f51d"
type: adr
name: "infrastructure の item は、仕組みの単位で分ける"
description: "infrastructure の item を文書の検証・ホスティングの設定・ビルドとリリースの仕組みの単位で分け、支えの無い quality をそれぞれへ振り分ける。"
section: authoring
status: stable
sources:
  - id: "issue-31"
    resource: "https://github.com/yasunori0418/mitodoke/issues/31"
    title: "epic: 規範とテスト計画を支える仕組みを決める — infrastructure に satisfies されていない quality と、test_plan の支え"
origin: "#31 の grilling（2026-11-26）で確定"
justifies:
  - "INF-b341594a-d24c-4425-9e60-d812d1a5ea64"
  - "INF-7d683bd6-5d87-48e7-ad50-2147dcfbe793"
  - "INF-dee49f6e-3499-4d26-9a97-2cd6e03a5d0f"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:28:48+09:00"
---

# infrastructure の item は、仕組みの単位で分ける

- ステータス: stable
- 日付: 2026-11-26
- 関連: [まだ作っていない仕組みは、status が draft の item で表す](planned-mechanisms-as-draft-items.md), [quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す](quality-infrastructure-exempt.md), GitHub Issue #31
- 起点: #31 の grilling（2026-11-26）で確定

## 背景

2026-11-26 の時点で、`infrastructure` の item は検証基盤の 1 本だけで、`sara check`、契約テスト、`sara-gap`、
`sara-fresh`、`sara-verify`、`sara-new` をまとめて持っていた。どの `infrastructure` にも `satisfies` されて
いない `quality` のうち、まだ作っていない仕組みに支えられる 6 本を除く 15 本には、文書の検証の仕組みに
支えられるもの、issue フォームや main の ruleset に支えられるもの、仕組みで支えないものがあった。

## 決定

- `infrastructure` の item を、仕組みの単位（文書の検証、リポジトリのホスティングの設定、ビルドとリリース）で
  分ける
- 15 本のうち 10 本を検証基盤の item の `satisfies` に加える。2 本は新しい item「リポジトリのホスティングの
  設定」（`stable`）が `satisfies` する。3 本には `infrastructure_exempt` を書く
- 検証基盤の item に加える規範のうち、一部だけを仕組みが確かめるものは、残りをレビューで守ると本文に書く
- main の ruleset はこの決定で変えず、required の check を登録していないことを item の本文に書く

## 根拠

仕組みの単位で分けると、規範ごとに item を起こすより `satisfies` の先が読みやすい。

一部だけを仕組みが確かめる規範は、すでに `satisfies` されている規範にも同じ形のものがあるので、同じ扱いに
した。main の規範は required の check を登録するまで満たされないが、どの check を required にするかは
CI を作る #6 で決まるので、ruleset は変えない。

## 棄却した代替案

### 規範ごとに item を起こす

仕組みが同じ item が並んで本文が重なる。

### 検証基盤の item 1 本にすべてを入れる

issue フォームや ruleset は文書の検証ではない。

---
id: "ADR-450d36f8-34c8-4d0c-9ed8-258c3ec490d5"
type: adr
name: "バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る"
description: "mitodoke 自身の開発で、バージョンを一次情報 1 か所から導き、タグとリリースノートを自動で作る規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-0c13507d-a425-49ac-b98b-eca5185dfb40"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:47:19+09:00"
---
# バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI と配布を実装する前に、mitodoke
自身の開発の規範を決める必要があった。#6 のコメントは、mitodoke 自身のバージョンとタグの付け方が
決まっていないと書いていた。

## 決定

規範 [バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る](../quality/version-from-single-source-with-automated-tags.md)
を起こす。バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る。

一次情報の場所、タグの契機、cachix への push の契機は、この規範では決めない。配布を実装する
子の epic G（テストの区分の `distribution` に当たる範囲）が決める。

## 根拠

規範を先に書いておけば、子の epic G は配布を実装するときに、何を満たせばよいかを item から読める。

## 棄却した代替案

### quality にせず、子の epic G の詳細設計で決める

バージョンとタグの付け方を規範にせず、子の epic G の詳細設計で決める案。配布の形が固まる前に規範を
書くと、後で直すことになりうる。この案では、子の epic G が配布を実装するときに、何を満たせばよいかを
item から読めない。

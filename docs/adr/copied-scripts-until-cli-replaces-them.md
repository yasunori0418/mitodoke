---
id: "ADR-d1f2d28b-31d4-42b6-a10c-7467a8a7b395"
type: adr
name: "写した shell script で自身の文書を管理し、CLI が完成したら置き換える"
description: "mitodoke 自身の文書を写した shell script で管理し、CLI が完成したら CLI で置き換えると決める。"
section: migration-records
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling で利用者が示した開発方針"
justifies:
  - "INF-dee49f6e-3499-4d26-9a97-2cd6e03a5d0f"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:03+09:00"
---
# 写した shell script で自身の文書を管理し、CLI が完成したら置き換える

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling で利用者が示した開発方針

## 背景

mitodoke は、shell script で行っている文書の作成と検査を、1 つの CLI として製品にするものである。
CLI ができるまでのあいだ、mitodoke 自身の文書を何で管理するかが決まっていなかった。layat には、
文書の起票・一覧の生成・検査を行う shell script と、その契約テストがすでにある。

## 決定

- mitodoke の開発でも、layat の shell script をコピーして、mitodoke 自身の文書管理に使う
- mitodoke が 1 つのツールとして完成したら、コピーした shell script を CLI で置き換える

## 根拠

この方針は、利用者が grilling の途中で開発方針として示したものである。記録に、これを超える根拠は
無い。

## 棄却した代替案

記録に、比べた代替案は無い。この方針は選択肢を並べて選んだものではなく、利用者が開発方針として
示したものである。

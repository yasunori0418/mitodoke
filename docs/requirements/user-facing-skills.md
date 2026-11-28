---
id: "REQ-8326a020-bdac-41a5-a21f-8d3ca92d9a69"
type: requirement
name: "利用者向けのスキルは公開用として英語で書く"
description: "mitodoke が利用者向けに公開するスキルを英語で書くことを定める。"
specification: "The user-facing skills that mitodoke publishes SHALL be written in English."
specification_ja: "mitodoke が利用者向けに公開するスキルは、英語で書かなければならない。"
risk_exempt: "スキルの文書を書く言語を定める要件で、CLI の振る舞いの退行では破れない。"
section: distribution
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:15+09:00"
---
# 利用者向けのスキルは公開用として英語で書く

## 仕様

mitodoke が利用者向けに公開するスキルは、英語で書く。利用者向けのスキルは、利用者が自分の
リポジトリで使うもので、文書のモデルの構造を知ったうえで CLI を使う手順をエージェントに与える。

公開するスキルの範囲と名前、配り方は、この item では定めない。

## 出典

根拠の決定は次の ADR が持つ。

- [利用者向けのスキルを公開用として英語で書く](../adr/user-skills-written-in-english.md)

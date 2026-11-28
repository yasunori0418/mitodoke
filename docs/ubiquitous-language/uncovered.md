---
id: "UBQ-e6d4e8e6-f568-411e-b67e-0159f97c7acc"
type: ubiquitous_term
name: "uncovered"
description: "検証へ向かう連鎖が期待するつながりを欠いている item の状態。"
name_ja: "未カバー"
avoid:
  - "ギャップ"
section: inspection
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:35+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:20:36+09:00"
---
# uncovered

## Definition

The state of an item that lacks a relation the chain toward verification expects it to
have, such as a risk that no test condition reduces, a test condition that no test case
covers, or a test case that follows no test plan. Uncovered items are enumerated and
reported; how to fill them is judged by a person.

## Avoid

- ギャップ: a vague word that does not say what is missing. Write 未カバー.

## 定義

検証へ向かう連鎖が期待するつながりを欠いている item の状態。どのテスト条件にも
減らされないリスク、どのテストケースにもカバーされないテスト条件、どのテスト計画にも
従わないテストケースなどがある。未カバーの item は列挙して報告し、どう埋めるかは人間が
判断する。

## 避ける表現

- ギャップ: 何が欠けているかを言わない語。未カバーと書く。

---
id: "ADR-cf26f12e-d5ef-4038-9b28-ddba40b2b375"
type: adr
name: "sara の挙動の回帰は別のレベルにせず、mitodoke の結果で確かめる"
description: "sara の挙動の回帰を別のテストのレベルにせず、#6 のコメントの 3.1 節の実験の入力を受け入れテストの fixture にして mitodoke の結果を期待にし、sara-core 自体が何を返すかは確かめない。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "TP-cefb0111-5c50-4f89-8955-b63b3c5904c8"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:14:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:41:26+09:00"
---
# sara の挙動の回帰は別のレベルにせず、mitodoke の結果で確かめる

- ステータス: stable
- 日付: 2026-11-24
- 関連: [sara は必要なときに上げ、Cargo.lock と flake の input を同じタグに揃える](sara-upgraded-when-needed.md), [mitodoke 自身のテストのレベルを、単体のテストと受け入れテストの 2 つにする](two-test-levels-unit-and-acceptance.md), GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

#6 のコメントの 3.1 節では sara の挙動を実験で確かめた。mitodoke の検査が要る理由になっている挙動は、
`covers` が無くても成功すること、未知のキーを受け付けること、値の形を見ないこと、`orphan` の判定、相互の
`references` が循環になることである。

sara を上げるときは、受け入れテストと `mitodoke check` を成功させると決めてある。これらの挙動を回帰として
受け入れテストで確かめるか、sara を上げるときの確認にするかは決まっていなかった。

## 決定

sara の挙動の回帰は別のレベルにしない。#6 のコメントの 3.1 節の実験の入力を受け入れテストの fixture にし、
mitodoke の結果を期待にする。sara-core 自体が何を返すかは確かめない。

## 根拠

sara の挙動を直接確かめるテストを持つと、sara を上げるたびに、mitodoke に関わらない差でも失敗しうる。
mitodoke の結果を期待にすれば、sara の挙動が変わって mitodoke の結果が変わったときだけ失敗する。

sara を上げる PR で受け入れテストを成功させる決定とも合う。

## 棄却した代替案

### sara-core を直接呼ぶテストとして独立させる

sara の挙動の回帰を、sara-core を直接呼ぶテストとして独立させる案。sara を上げたときに、どの挙動が
変わったかを直接読める。ただし、sara を上げるたびに mitodoke に関わらない差でも失敗しうる。

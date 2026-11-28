---
id: "ADR-f8692e4c-55d4-4ef4-a5c6-dc7c80a2c25c"
type: adr
name: "テストの区分を製品の概念にし、中身は設定で決める"
description: "テストの区分を製品の概念にして中身を設定の 1 つの一覧で決め、テスト条件とテストケースのディレクトリ・risk の section・index の見出しをその一覧から導く。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q7）で確定"
justifies:
  - "REQ-9ab110e1-6a93-4c21-b5c3-d9023a77d5c1"
references:
  - "ADR-5cc4a493-1c96-4703-a2b1-19e43bf95a30"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:47+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:01:14+09:00"
---
# テストの区分を製品の概念にし、中身は設定で決める

- ステータス: stable
- 日付: 2026-11-17
- 関連: [risk の節はテストの区分と同じ語彙にする](risk-sections-follow-test-categories.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q7）で確定

## 背景

mitodoke へ写した文書管理の仕組みでは、テストの区分は機能の単位で、1 つの一覧のファイルが区分を
持つ。test_condition と test_case は区分ごとのディレクトリ `docs/test/<区分>/` に置き、test_case と
テスト資産の対応の検査は、区分の一覧と `docs/test/` のディレクトリが一致することも確かめる。
risk の `section` の値は区分と同じにする。

mitodoke を製品にするにあたり、この区分を製品の概念にするか、するなら risk の `section` と
どう結びつけるかを決めなければならない。

## 決定

テストの区分を製品の概念にし、中身は設定で決める。

- test_condition と test_case は `docs/test/<区分>/` に置く
- risk の `section` の値にも区分を使う
- 設定の 1 つの一覧から、ディレクトリ・risk の `section`・index の見出しを導く

## 根拠

区分の一覧を設定に 1 つ書けば、ディレクトリ・risk の `section`・index の見出しのすべてに使える。
保守する一覧が 1 つで済み、区分の一覧とディレクトリの一致の検査も保てる。

## 棄却した代替案

### 区分を製品の概念にするが、risk の section は区分と切り離して別に設定する

区分の一覧と risk の `section` の一覧の 2 つを保守することになる。

### 区分を製品の概念にせず、プロジェクトが独自に決める

test_condition と test_case を `docs/test/` の直下に置き、分けたいプロジェクトが独自に決める案。
区分とディレクトリの一致の検査がなくなり、テストの多いプロジェクトで item を探しにくくなる。

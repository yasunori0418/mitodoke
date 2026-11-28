---
id: "REQ-9ab110e1-6a93-4c21-b5c3-d9023a77d5c1"
type: requirement
name: "テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く"
description: "テストの区分は製品の概念で、中身は設定の 1 つの一覧で決め、テスト条件とテストケースの置き場所・risk の section の値・index の見出しをその一覧から導く。"
specification: |
  mitodoke SHALL treat test categories as a concept of the product, and the configuration
  file SHALL define the test categories as a single list. test_condition and test_case items
  SHALL be placed under `docs/test/<category>/`, where `<category>` is a test category in that
  list. mitodoke SHALL derive from the same list the directories of test_condition and
  test_case items, the values of the `section` field of risk, and the headings of the index for
  each test category.
specification_ja: |
  mitodoke はテストの区分を製品の概念として扱わなければならず、設定ファイルはテストの区分を
  1 つの一覧として定めなければならない。test_condition と test_case の item は、その一覧にある
  区分の `docs/test/<区分>/` に置かなければならない。mitodoke は、同じ一覧から、test_condition と
  test_case の item のディレクトリ、risk の `section` の値、区分ごとの index の見出しを導かなければ
  ならない。
section: model-config
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:27+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:57:38+09:00"
---
# テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く

## 仕様

テストの区分は製品の概念で、中身は設定ファイルの 1 つの一覧で決める。

- test_condition と test_case の item は、一覧にある区分の `docs/test/<区分>/` に置く
- risk の `section` の値にも、テストの区分を使う
- test_condition と test_case のディレクトリ、risk の `section` の値、区分ごとの index の見出しは、
  すべて同じ一覧から導く

## 出典

根拠の決定は次の ADR が持つ。

- [テストの区分を製品の概念にし、中身は設定で決める](../adr/test-categories-configured-per-product.md)

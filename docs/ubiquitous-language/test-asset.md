---
id: "UBQ-0bf22ca0-825e-4e76-8640-e50471421645"
type: ubiquitous_term
name: "test asset"
description: "テストケースが対応する、単独で実行できるテストの単位。"
name_ja: "テスト資産"
section: inspection
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:35+09:00"
---
# test asset

## Definition

An independently runnable unit of test, such as a test file or a test scenario, that a
test case corresponds to. A test case and its test asset correspond one to one, which
links the intent written in the document graph with its implementation. The
correspondence shows where a test is implemented; it does not prove that the test is
correct or that it detects the defect it aims at.

## 定義

テストファイルやテストシナリオのような、単独で実行できるテストの単位で、テストケースが
対応するもの。テストケースとテスト資産は一対一で対応し、ドキュメントグラフに書いたテストの
意図と、その実装を結ぶ。この対応はテストがどこに実装されているかを示すが、テストが正しい
ことや、狙った欠陥を検出できることまでは示さない。

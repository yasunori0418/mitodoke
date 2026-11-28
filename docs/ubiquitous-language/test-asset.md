---
id: "UBQ-0bf22ca0-825e-4e76-8640-e50471421645"
type: ubiquitous_term
name: "test asset"
description: "テストケースが対応する、テストの実体の単位。"
name_ja: "テスト資産"
section: inspection
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:36:33+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:20:09+09:00"
---
# test asset

## Definition

The unit of a test's substance that a test case corresponds to. It covers what runs
automatically, such as a test file, a test scenario or a flake check, and also the
procedure and test charter files of tests that a person performs. Records of carrying out
a test are not test assets. A test case and its test asset correspond one to one, which
links the intent written in the document graph with its implementation. The
correspondence shows where a test is implemented; it does not prove that the test is
correct or that it detects the defect it aims at. A file of steps that a person follows is
written 手順書 (procedure) in Japanese documents. The JSTQB term テストプロシジャー (test
procedure) is an order in which several test cases are executed, which is a different
scope from a 手順書.

## 定義

テストケースが対応する、テストの実体の単位。テストファイル、テストシナリオ、flake check の
ように自動で実行するものに加えて、人が行うテストの手順書とテストチャーターのファイルを含む。
テストの実施の記録はテスト資産に含めない。テストケースとテスト資産は一対一で対応し、
ドキュメントグラフに書いたテストの意図と、その実装を結ぶ。この対応はテストがどこに実装されて
いるかを示すが、テストが正しいことや、狙った欠陥を検出できることまでは示さない。人が従う
1 本の手順のファイルは「手順書」と書く。JSTQB のテストプロシジャーは複数のテストケースを実行
する順序のことで、手順書とは範囲が違う。

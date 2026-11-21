---
id: "UBQ-671dde2d-1897-40cb-9982-3c35d28fc005"
type: ubiquitous_term
name: "structural contract"
description: "検査の 3 つの分類の 1 つで、item とドキュメントグラフの形が整っているかを確かめるもの。"
name_ja: "構造の契約"
section: inspection
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:53+09:00"
---
# structural contract

## Definition

One of the three categories of inspection: a check on whether items and the document
graph are well-formed. It covers the validity of the graph, the shape of the
frontmatter, where IDs are written, the match between the type of an item and its
location, the one-to-one correspondence between test cases and test assets, the
derivation of a risk's `level`, that the target of `supersedes` is `deprecated`, and
that generated `index.md` files do not differ from the committed ones. By default a
violation of a structural contract is a failure.

## 定義

検査の 3 つの分類の 1 つで、item とドキュメントグラフの形が整っているかを確かめるもの。
グラフの整合、frontmatter の形、ID の置き場所、item の型と置き場所の一致、テストケースと
テスト資産の 1:1、リスクの `level` の導出、`supersedes` の先が `deprecated` であること、生成
した `index.md` がコミットされたものと差分を持たないことを含む。既定では、構造の契約の違反を
失敗にする。

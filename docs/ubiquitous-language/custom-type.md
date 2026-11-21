---
id: "UBQ-49eabc1d-8bff-4f6f-96bc-5cac22541394"
type: ubiquitous_term
name: "custom type"
description: "製品が、組み込みの型に加えて、設定でモデルに足す型。"
name_ja: "独自の型"
section: model-types
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:54+09:00"
---
# custom type

## Definition

A type that a product adds to the model by configuration, in addition to the built-in
types. Custom types can only be added; they do not replace or change a built-in type.
Contracts that work on every type, such as the shape of the frontmatter, where IDs are
written and the generation of `index.md`, apply to a custom type, while contracts
specific to a type do not.

## 定義

製品が、組み込みの型に加えて、設定でモデルに足す型。独自の型は追加だけができ、組み込みの型を
置き換えたり変えたりはしない。frontmatter の形、ID の置き場所、`index.md` の生成のような、す
べての型に働く契約は独自の型にも及び、型に固有の契約は及ばない。

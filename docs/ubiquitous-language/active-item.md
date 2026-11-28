---
id: "UBQ-e0b32804-6c6f-4bbd-9be3-9912d0ab2b53"
type: ubiquitous_term
name: "active item"
description: "`status` が `deprecated` でない item。`draft` を含む。"
name_ja: "有効な item"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:44:21+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:17:25+09:00"
---
# active item

## Definition

An [item](item.md) whose `status` is not `deprecated`; a `draft` item is an active item.
`gap` and `fresh` count only active items in every section, and count an edge only when
both of its ends are active items. The structural contracts of `check` apply to deprecated
items as well. The term pairs with the heading of the last section of `index.md`, which
lists the items that are not active. "Valid item" is not the canonical name, because it is
confused with the `valid` result of `sara check`.

## 定義

`status` が `deprecated` でない [item](item.md)。`draft` の item も有効な item である。`gap` と
`fresh` は、すべての節で有効な item だけを数え、辺は両端が有効な item のものだけを数える。
`check` の構造の契約は、`deprecated` の item にも働く。`index.md` の末尾の節の見出し
「有効でない item」と対になる。valid item は `sara check` の結果の `valid` と紛れるので、
正名にしない。

---
id: "UBQ-2af17902-f3d0-4bb9-a3be-28d1b5a1cb2c"
type: ubiquitous_term
name: "full ID"
description: "`<PREFIX>-<フル UUIDv4>` の形で item を一意に指す ID。"
name_ja: "フル ID"
avoid:
  - "正式 ID"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
---
# full ID

## Definition

The ID that identifies an item, in the form `<PREFIX>-<full UUIDv4>`, where the prefix
names the item's model type. A full ID is written only in the frontmatter `id:` and in
relation lists; prose refers to an item with a link whose text is the item's name. An
8-character short form is not used.

## Avoid

- 正式 ID: another Japanese name for the same ID. Write フル ID.

## 定義

item を一意に指す、`<PREFIX>-<フル UUIDv4>` の形の ID。prefix は item のモデルの型を表す。
フル ID は frontmatter の `id:` と relation のリストだけに書き、散文では item の name を文字列に
したリンクで item に触れる。8 文字の省略形は使わない。

## 避ける表現

- 正式 ID: 同じ ID を指す別の日本語名。フル ID と書く。

---
id: "UBQ-0ff35c0f-9780-4035-aa6d-7e7296308751"
type: ubiquitous_term
name: "item"
description: "ドキュメントグラフを構成する、frontmatter を持つ Markdown ファイル 1 つ。"
avoid:
  - "アイテム"
section: graph
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:38+09:00"
---
# item

## Definition

One Markdown file in the document graph whose frontmatter gives it an ID, a model type and
a name. An item states one thing of its type, such as one requirement, one risk or one
term, and is joined to other items by relations. Its ID is a full ID, and its file name is
its slug.

## Avoid

- アイテム: a katakana spelling. Write item.

## 定義

ドキュメントグラフを構成する Markdown ファイル 1 つ。frontmatter で ID・モデルの型・name を
持ち、要件 1 つ、リスク 1 つ、用語 1 語のように、その型の 1 件を述べる。ほかの item とは
relation で結ばれる。ID はフル ID で、ファイル名は slug にする。

## 避ける表現

- アイテム: カタカナの表記。item と書く。

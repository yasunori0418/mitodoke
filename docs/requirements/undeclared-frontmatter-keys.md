---
id: "REQ-9c54aa84-e2db-42d7-87af-f1fec5c64a63"
type: requirement
name: "宣言の無い frontmatter のキーは構造の契約の違反とする"
description: "sara の組み込みのキーでも、model で宣言されたフィールドや relation でもない frontmatter のキーを構造の契約の違反とし、OKF のキーは違反にしない。"
specification: |
  A frontmatter key of an item that is neither a built-in key of sara nor a field or relation
  declared in the model SHALL be a violation of a structural contract. The OKF keys
  `generated`, `verified`, `sources` and `stale_after` SHALL NOT be treated as undeclared
  keys.
specification_ja: |
  sara の組み込みのキーでも、model で宣言されたフィールドや relation でもない item の
  frontmatter のキーは、構造の契約の違反としなければならない。OKF のキー `generated`・
  `verified`・`sources`・`stale_after` は、宣言の無いキーとして扱ってはならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:54:53+09:00"
---
# 宣言の無い frontmatter のキーは構造の契約の違反とする

## 仕様

item の frontmatter に、sara の組み込みのキーでも、model で宣言されたフィールドや relation
でもないキーがあれば、構造の契約の違反になる。
違反は `mitodoke check` で失敗になり、強さはほかの検査と同じく設定で変えられる。

OKF のキー（`generated`・`verified`・`sources`・`stale_after`）は mitodoke が扱うキーなので、
宣言が無くても違反にしない。

## 出典

根拠の決定は次の ADR が持つ。

- [宣言の無い frontmatter のキーを構造の契約の違反にする](../adr/undeclared-frontmatter-keys-rejected.md)

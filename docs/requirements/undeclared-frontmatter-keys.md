---
id: "REQ-9c54aa84-e2db-42d7-87af-f1fec5c64a63"
type: requirement
name: "宣言の無い frontmatter のキーは構造の契約の違反とする"
description: "sara の組み込みのキー、OKF の 4 つのキー、その item の型で宣言されたフィールドと relation のどれでもない frontmatter のキーを構造の契約の違反とする。"
specification: |
  mitodoke SHALL accept only the following frontmatter keys on an item: the built-in keys of sara,
  the four OKF keys `generated`, `verified`, `sources` and `stale_after`, and the fields and
  relations declared for the type of that item. Any other frontmatter key, including a field
  declared only for another type, SHALL be a violation of a structural contract.
specification_ja: |
  mitodoke が item の frontmatter で受け付けるキーは、sara の組み込みのキー、OKF の 4 つのキー
  `generated`・`verified`・`sources`・`stale_after`、その item の型で宣言されたフィールドと relation
  だけでなければならない。それ以外の frontmatter のキーは、ほかの型だけで宣言されたフィールドを含め、
  構造の契約の違反としなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:54:50+09:00"
---
# 宣言の無い frontmatter のキーは構造の契約の違反とする

## 仕様

item の frontmatter で受け付けるキーは、sara の組み込みのキー、OKF の 4 つのキー（`generated`・`verified`・
`sources`・`stale_after`）、その item の型で宣言されたフィールドと relation だけとする。それ以外のキーは、
ほかの型だけで宣言されたフィールドを含め、構造の契約の違反になる。
違反は `mitodoke check` で失敗になり、強さはほかの検査と同じく設定で変えられる。

## 出典

根拠の決定は次の ADR が持つ。

- [宣言の無い frontmatter のキーを違反にし、宣言はその item の型のものに限る](../adr/undeclared-frontmatter-keys-per-type.md)

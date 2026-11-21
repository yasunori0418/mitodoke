---
id: "REQ-69c1c6b2-bbb7-425b-8256-9f340d9ad36f"
type: requirement
name: "組み込みの定義は設定で削除も変更もできない"
description: "設定は独自の型・relation・フィールドを追加できるが、組み込みの型・relation・フィールドを削除も変更もできない。"
specification: |
  The configuration file SHALL allow adding custom types, custom relations, and custom
  fields. The configuration file SHALL NOT delete or modify the built-in types or the
  relations and fields of the built-in types. As the only exception, the configuration file
  SHALL allow adding, to a built-in type, a relation whose `allowed_targets` point to custom
  types.
specification_ja: |
  設定ファイルは、独自の型・relation・フィールドを追加できなければならない。設定ファイルは、
  組み込みの型と、その relation・フィールドを削除も変更もしてはならない。唯一の例外として、
  設定ファイルは、組み込みの型から独自の型へ張れる relation（`allowed_targets`）を加えることを
  許さなければならない。
section: model-config
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:03+09:00"
---
# 組み込みの定義は設定で削除も変更もできない

## 仕様

設定ファイルでは、独自の型・relation・フィールドを追加できる。組み込みの型と、その relation・
フィールドは、設定で削除も変更もできない。

ただし、組み込みの型から独自の型へ張れる relation（`allowed_targets`）を加えることは許す。

## 出典

根拠の決定は次の ADR が持つ。

- [独自の型・relation・フィールドは追加だけを許す](../adr/custom-definitions-additive-only.md)

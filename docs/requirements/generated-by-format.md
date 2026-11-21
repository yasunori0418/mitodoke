---
id: "REQ-a69187a5-ad91-4cee-bf29-efa34e79f812"
type: requirement
name: "generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む"
description: "generated.by の値は書式を限らず、空の値と二重引用符・バックスラッシュ・改行を含む値だけを拒み、値を判定には使わない。"
specification: |
  mitodoke SHALL accept any string as the value of generated.by, and SHALL reject only an empty value
  and a value that contains a double quote, a backslash, or a newline. mitodoke SHALL NOT use the
  value of generated.by in any of its judgments.
specification_ja: |
  mitodoke は、generated.by の値として任意の文字列を受け付け、拒むのは空の値と、二重引用符・
  バックスラッシュ・改行を含む値だけでなければならない。mitodoke は、generated.by の値をどの判定にも
  使ってはならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:19+09:00"
---
# generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む

## 仕様

- `generated.by` の値は、書式を限らない自由な文字列とする
- 拒むのは、空の値と、`"`・`\`・改行を含む値だけとする
- `mitodoke` は、`generated.by` の値を判定に使わない

## 出典

根拠の決定は次の ADR が持つ。

- [generated.by は自由な文字列にする](../adr/generated-by-free-form-string.md)

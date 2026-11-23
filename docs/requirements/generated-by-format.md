---
id: "REQ-a69187a5-ad91-4cee-bf29-efa34e79f812"
type: requirement
name: "generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む"
description: "generated.by の値は書式を限らず、空の値と二重引用符・バックスラッシュ・改行を含む値だけを、起票の入力と check による既存の item の検査の両方で拒み、値を判定には使わない。"
specification: |
  mitodoke SHALL accept any string as the value of generated.by, and SHALL reject only an empty value
  and a value that contains a double quote, a backslash, or a newline. mitodoke SHALL reject such a
  value both in the input of item creation and when check inspects an existing item. mitodoke SHALL
  NOT use the value of generated.by in any of its judgments.
specification_ja: |
  mitodoke は、generated.by の値として任意の文字列を受け付け、拒むのは空の値と、二重引用符・
  バックスラッシュ・改行を含む値だけでなければならない。mitodoke は、これらの値を、起票の入力と、
  check が既存の item を検査するときの両方で拒まなければならない。mitodoke は、generated.by の値を
  どの判定にも使ってはならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:22:45+09:00"
---
# generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む

## 仕様

- `generated.by` の値は、書式を限らない自由な文字列とする
- 拒むのは、空の値と、`"`・`\`・改行を含む値だけとする
- これらの値は起票の入力と、`check` が既存の item を検査するときの両方で拒む
- `mitodoke` は、`generated.by` の値を判定に使わない

## 出典

根拠の決定は次の ADR が持つ。

- [generated.by は自由な文字列にする](../adr/generated-by-free-form-string.md)

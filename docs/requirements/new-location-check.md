---
id: "REQ-a69171a6-7587-4d92-8fce-1cf84d62b36f"
type: requirement
name: "new は引数の置き場所を型ごとの置き場所と比べ、合わなければ起票を拒む"
description: "mitodoke new は置き場所を引数で受け取り、設定の型ごとの置き場所と合わない起票を拒む。"
specification: |
  mitodoke new SHALL take the location of the new item as an argument, in the form
  `mitodoke new <type> <slug> <location> -- ...`. mitodoke new SHALL compare the given location with
  the location configured for the type, and SHALL refuse to create the item when they do not match.
  For test_condition and test_case, mitodoke new SHALL also verify that the location has the form
  `docs/test/<category>/` and that the category is defined in the configuration, and SHALL refuse to
  create the item otherwise.
specification_ja: |
  mitodoke new は、新しい item の置き場所を `mitodoke new <型> <slug> <置き場所> -- ...` の形の引数で
  受け取らなければならない。mitodoke new は、受け取った置き場所を設定の型ごとの置き場所と比べ、
  合わなければ起票を拒まなければならない。test_condition と test_case では、置き場所が
  `docs/test/<区分>/` の形であることと、その区分が設定にあることも確かめ、満たさなければ起票を
  拒まなければならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:19+09:00"
---
# new は引数の置き場所を型ごとの置き場所と比べ、合わなければ起票を拒む

## 仕様

- `mitodoke new` は、新しい item の置き場所を引数で受け取る。形は `mitodoke new <型> <slug> <置き場所> -- ...` とする
- 受け取った置き場所を設定の型ごとの置き場所と比べ、合わなければ起票を拒む
- test_condition と test_case では、置き場所が `docs/test/<区分>/` の形であることと、その区分が設定にあることも確かめ、満たさなければ起票を拒む

## 出典

根拠の決定は次の ADR が持つ。

- [new は置き場所を引数で受け取り、型ごとの置き場所と比べる](../adr/new-takes-location-argument.md)

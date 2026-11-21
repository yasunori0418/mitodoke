---
id: "REQ-5c52b41a-9015-4c68-8143-b813f13064fa"
type: requirement
name: "item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない"
description: "設定に型ごとの置き場所を持ち、item の型と置き場所の一致を構造の契約として確かめ、index の見出しも同じ表から決める。"
specification: |
  The configuration file SHALL hold the location of each type, including custom types.
  mitodoke SHALL check, as a structural contract, that the location of every item matches the
  location that the configuration file holds for the item's type, and SHALL detect a test_case
  placed outside `docs/test/` as a mismatch. mitodoke SHALL determine the headings of the index
  from the same table of locations.
specification_ja: |
  設定ファイルは、独自の型を含む型ごとの置き場所を持たなければならない。mitodoke は、すべての item
  の置き場所が、設定ファイルがその item の型に持つ置き場所と一致することを構造の契約として
  確かめなければならず、`docs/test/` の外に置いた test_case を不一致として見つけなければ
  ならない。mitodoke は、index の見出しを同じ置き場所の表から決めなければならない。
section: model-config
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:40+09:00"
---
# item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない

## 仕様

- 設定ファイルは、独自の型を含む型ごとの置き場所を持つ
- item の置き場所が、その型に設定した置き場所と一致することを、構造の契約として確かめる。
  `docs/test/` の外に置いた test_case も、この一致で見つける
- index の見出しも、同じ置き場所の表から決める

## 出典

根拠の決定は次の ADR が持つ。

- [型と置き場所の一致を構造の契約にし、型ごとの置き場所を設定に持つ](../adr/type-location-match-is-structural-contract.md)

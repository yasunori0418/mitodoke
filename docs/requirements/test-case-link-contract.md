---
id: "REQ-3f258649-995e-404f-8bda-52fba8c0281d"
type: requirement
name: "test_case は covers と follows をそれぞれ 1 本以上持たなければならない"
description: "test_case が covers と follows をそれぞれ 1 本以上持つことを構造の契約とし、どちらかが欠けた test_case を違反とする。"
specification: |
  Every test_case SHALL declare at least one `covers` relation and at least one `follows`
  relation. A test_case lacking either SHALL be a violation of a structural contract.
specification_ja: |
  すべての test_case は、`covers` の relation と `follows` の relation をそれぞれ 1 本以上
  持たなければならない。どちらかを欠く test_case は、構造の契約の違反としなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:36+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-23T13:41:50+09:00"
---
# test_case は covers と follows をそれぞれ 1 本以上持たなければならない

## 仕様

test_case は、どの test_condition を確かめるか（`covers`）と、どの test_plan に従うか
（`follows`）の両方を、それぞれ 1 本以上持つ。どちらかが欠けた test_case は、構造の契約の
違反になる。

sara の検査は、どちらか 1 本を持つ test_case を受け付けるので、この契約は mitodoke の検査が
確かめる。

## 出典

根拠の決定は次の ADR が持つ。

- [test_case は covers と follows をそれぞれ 1 本以上持つ](../adr/test-case-requires-covers-and-follows.md)

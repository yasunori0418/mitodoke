---
id: "REQ-f78bd468-dd61-4564-9287-aec3a8ad6ba4"
type: requirement
name: "用語の一覧と avoid を JSON で出力する"
description: "用語の一覧と各用語の avoid を JSON で出力し、避ける綴りの検査そのものは mitodoke に持たない。"
specification: |
  mitodoke SHALL output the list of ubiquitous terms, including the `avoid` spellings of
  each term, as JSON. mitodoke SHALL NOT itself check documents for `avoid` spellings, and
  SHALL NOT invoke textlint.
specification_ja: |
  mitodoke は、用語の一覧を、各用語の `avoid` の綴りを含めて JSON で出力しなければならない。
  mitodoke は、文書に `avoid` の綴りが無いかを自身で検査してはならず、textlint を呼び出しても
  ならない。
section: inspection
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:36+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:03:24+09:00"
---
# 用語の一覧と avoid を JSON で出力する

## 仕様

mitodoke は、用語の一覧と、各用語の `avoid`（使わない綴り）を JSON で出力する。避ける綴りが
文書に無いかの検査は、適用先の製品がこの出力を使って組み立てる。mitodoke は、その検査を
内蔵せず、textlint も呼ばない。

組み立て方の例として、textlint と prh の組み方を README などで案内する。

## 出典

根拠の決定は次の ADR が持つ。

- [避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](../adr/avoid-spelling-check-left-to-adopters.md)

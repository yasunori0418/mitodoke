---
id: "REQ-4ac9181f-5394-4617-b05e-be2387228008"
type: requirement
name: "export は文書 1 件を item とし、sara 0.12 の items[] の形に OKF のキーを加えて出す"
description: "export は文書 1 件ずつを item にし、sara 0.12 の items[] の形を写して OKF のキーを加えたものを item の info の下に置き、sara の形が変わっても自動では変えない。"
specification: |
  export SHALL represent each document as one item of the result envelope. Under the info of
  each item, export SHALL place the document in the shape copied from items[] of the JSON output
  of check in sara 0.12, with the OKF keys generated, verified, sources and stale_after added.
  When the shape in sara changes, mitodoke SHALL NOT change the shape of export automatically.
specification_ja: |
  export は、文書 1 件を結果エンベロープの item 1 つで表さなければならない。export は、各 item の
  info の下に、sara 0.12 の check の JSON 出力の items[] から写した形に OKF のキー generated・
  verified・sources・stale_after を加えた形で、その文書を置かなければならない。sara の形が
  変わっても、mitodoke は export の形を自動で変えてはならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:35:03+09:00"
---
# export は文書 1 件を item とし、sara 0.12 の items[] の形に OKF のキーを加えて出す

## 仕様

`export` は、文書 1 件を結果エンベロープの item 1 つで表す。item の `info` の下には、sara 0.12 の
`sara check --format json` の `items[]` から写した形に、OKF のキー（`generated`・`verified`・
`sources`・`stale_after`）を加えて、その文書を置く。

この形は mitodoke の形として固定する。sara を上げて sara の形が変わっても、`export` の形は
自動では変わらない。変えるかどうかは、mitodoke の側で決める。

JSON のキーの名前と relation の表し方の細部は、この要求では定めない。

## 出典

根拠の決定は次の ADR が持つ。

- [export は sara 0.12 の items[] の形を写して固定し、OKF のキーを加える](../adr/export-shape-fixed-from-sara-items.md)

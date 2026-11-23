---
id: "UC-76b72c4b-ab13-45a4-9ad6-392bf3cb0c8e"
type: use_case
name: "避ける綴りの検査を内蔵する"
description: "利用者が、用語の避ける綴りが文書に無いことを mitodoke 自身に検査させ、検査を自分で組み立てずに済ませる。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:31:01+09:00"
---
# 避ける綴りの検査を内蔵する

> **棄却**: この提案は採らない。mitodoke は避ける綴りの検査を内蔵せず、textlint も呼ばない。適用先の製品が、
> mitodoke の JSON 出力（用語の一覧と `avoid`）を使って検査を組み立てる。決定は
> [避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](../adr/avoid-spelling-check-left-to-adopters.md)
> にある。

## 提案した使われ方

利用者は `ubiquitous_term` の `avoid` に書いた綴りが文書の本文に無いことを、mitodoke 自身に検査させる。
mitodoke が Markdown を解析して本文の綴りを探すか、textlint と prh を CLI の中から呼ぶので、利用者は
検査を自分で組み立てない。

## 作らない理由

JSON 出力から辞書と設定を作って検査する形は、mitodoke のリポジトリの `dev/tests/term-avoid.sh` ですでに
動いている。検査を外で組み立てられるので、製品に取り込まない。textlint と prh を CLI から呼ぶ案は、
適用先の製品に Node の実行環境と textlint を求めることになる。

## 出典

根拠の決定は次の ADR が持つ。

- [避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](../adr/avoid-spelling-check-left-to-adopters.md)

---
id: "UC-af665485-5e6e-431d-b409-8ccf92473781"
type: use_case
name: "既存の文書に generated を埋め戻す"
description: "既存の文書を持つ利用者が、mitodoke を導入するときに、mitodoke の CLI で既存の item に generated を埋め戻す。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:13:54+09:00"
---
# 既存の文書に generated を埋め戻す

> **棄却**: この提案は採らない。mitodoke の CLI は既存の文書へ `generated` を埋め戻す機能を持たず、README の
> 導入の手順に埋め戻しの例を載せる。決定は
> [既存の文書への generated の埋め戻しは CLI に持たず、README に例を載せる](../adr/generated-backfill-left-to-adopters.md)
> にある。

## 提案した使われ方

利用者は既存の文書を持つ自分の製品に mitodoke を導入するときに、mitodoke の CLI で既存の item に
`generated` を埋め戻す。CLI は git の履歴から、本文を最後に変えたコミットの時刻を `generated.at` に、
そのコミットの作者を `generated.by` に入れる。

## 作らない理由

git の履歴から `generated.by` を推定する規則は、製品ごとに違う。CLI に持つと、一度きりの移行のために
サブコマンドを保守することになる。埋め戻しの例は README の導入の手順に載せる。

## 出典

- [既存の文書への generated の埋め戻しは CLI に持たず、README に例を載せる](../adr/generated-backfill-left-to-adopters.md)

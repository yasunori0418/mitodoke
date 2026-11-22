---
id: "REQ-f27d4510-f215-403e-beda-b39fa824e368"
type: requirement
name: "fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する"
description: "mitodoke fresh は人の確認の無い有効な solution と use_case、stale_after の期限切れ、stale_after の間隔の超過を見直しの義務として報告する。"
specification: "As review obligations, mitodoke fresh SHALL report (1) a `solution` or `use_case` item whose `status` is not `deprecated` and that has no `verified` entry whose `by` begins with `human:` and whose `at` is at or after its `generated.at`, (2) an item whose `status` is not `deprecated` and whose `stale_after` is earlier than the current time, and (3) an item whose `status` is not `deprecated`, whose type has a configured interval of N days, and whose `stale_after` is later than its starting point plus N days. The starting point SHALL be the latest `verified[].at` whose `by` begins with `human:` and that is at or after `generated.at`, or `generated.at` when there is none. A type with no configured interval SHALL NOT be inspected under (3)."
specification_ja: "mitodoke fresh は見直しの義務として次を報告しなければならない。(1) `status` が `deprecated` でなく、`by` が `human:` で始まり `at` が `generated.at` 以降の `verified` の要素を持たない `solution` と `use_case`。(2) `status` が `deprecated` でなく、`stale_after` が現在時刻より前の item。(3) `status` が `deprecated` でなく、日数 N の間隔を設定した型の item のうち、`stale_after` が起点から N 日より先のもの。起点は `generated.at` 以降で `by` が `human:` で始まる `verified[].at` のうち最も新しい時刻とし、無ければ `generated.at` としなければならない。間隔を設定していない型は (3) として検査してはならない。"
section: inspection
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
---
# fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する

## 仕様

- 人の確認の無い有効な `solution` と `use_case` を報告する。[人の確認](../ubiquitous-language/human-verification.md)は、`by` が `human:` で始まり、`at` が `generated.at` 以降の `verified` の要素とする
- `stale_after` が現在時刻より前の有効な item を、[期限切れ](../ubiquitous-language/expired.md)として報告する
- 間隔を設定した型の有効な item のうち、`stale_after` が「起点 + N 日」より先のものを報告する。起点は `generated.at` 以降の最新の `human:` の `verified` の時刻で、無ければ `generated.at` とする。間隔を設定していない型は検査しない
- 「有効な」は、`status` が `deprecated` でないことを指し、`draft` を含む

## 出典

根拠の決定は次の ADR が持つ。

- [level が high の risk と、有効な solution と use_case に人の verified を求める](../adr/human-verified-required-for-high-risk-and-upper-layers.md)
- [solution に stale_after を必須にし、期限までの間隔を 90 日以内にする](../adr/solution-requires-stale-after-within-interval.md)

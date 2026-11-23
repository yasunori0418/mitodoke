---
id: "REQ-0827f299-fbdc-46ed-8a04-ca4378ad0c79"
type: requirement
name: "下流の item の基準時刻より上流の generated.at が新しければ、下流を再確認待ちとして報告する"
description: "上流の relation 7 つの直接の辺で、下流の item の基準時刻より上流の item の generated.at が新しければ、その下流の item を再確認待ちとして報告し、verified は自動で加えない。"
specification: |
  mitodoke SHALL report a downstream item as awaiting re-confirmation when the `generated.at` of
  an upstream item is newer than the reference time of the downstream item. The reference time of
  an item SHALL be the latest of its `generated.at` and the `at` values of its `verified` entries
  at or after `generated.at`, regardless of the actor, and SHALL be its `generated.at` when the
  item has no `verified`. The built-in relations that mitodoke follows SHALL be `refines`,
  `derives_from`, `satisfies`, `threatens`, `mitigates`, `covers` and `follows`, and the item
  that declares the relation SHALL be the downstream item. mitodoke SHALL NOT follow `justifies`
  or the peer relations `depends_on`, `supersedes` and `references`. An item whose `status` is
  `deprecated` SHALL be excluded both as an upstream item and as a downstream item. mitodoke SHALL
  compare only direct edges. mitodoke SHALL read `generated.at` and `verified[].at` as instants
  and SHALL compare them as instants, not as strings. A `verified` entry whose actor is not `human:` SHALL count toward
  the reference time and SHALL NOT count as a human verification. mitodoke SHALL only report the
  result and SHALL NOT add `verified` automatically.
specification_ja: |
  mitodoke は、下流の item の基準時刻より上流の item の `generated.at` が新しければ、その下流の item を
  再確認待ちとして報告しなければならない。item の基準時刻は、その item の `generated.at` と、
  `generated.at` 以降の `verified[].at`（actor を問わない）のうち最も新しい時刻でなければならず、
  `verified` が無ければ `generated.at` でなければならない。mitodoke が辿る組み込みの relation は
  `refines`・`derives_from`・`satisfies`・`threatens`・`mitigates`・`covers`・`follows` の 7 つで
  なければならず、relation を宣言している item を下流としなければならない。mitodoke は、`justifies` と
  peer の relation（`depends_on`・`supersedes`・`references`）を辿ってはならない。`status` が
  `deprecated` の item は、上流としても下流としても対象から外さなければならない。mitodoke は、直接の辺
  だけを比べなければならない。mitodoke は、`generated.at` と `verified[].at` を、文字列ではなく時刻として
  読んで比べなければならない。`human:` 以外の actor の `verified` は、基準時刻には数えなければならず、
  人の確認には数えてはならない。mitodoke は、結果を報告に留め、`verified` を自動で加えてはならない。
section: inspection
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:49:01+09:00"
---
# 下流の item の基準時刻より上流の generated.at が新しければ、下流を再確認待ちとして報告する

## 仕様

下流の item の基準時刻より上流の item の `generated.at` が新しければ、その下流の item を再確認待ちとして報告する。

- 基準時刻は、その item の `generated.at` と、`generated.at` 以降の `verified[].at`（actor を問わない）のうち最も新しい時刻とする。`verified` が無ければ `generated.at` とする
- 辿る組み込みの relation は `refines`・`derives_from`・`satisfies`・`threatens`・`mitigates`・`covers`・`follows` の 7 つとする。relation を宣言している item が下流で、指されている item が上流である
- `justifies` と、peer の relation（`depends_on`・`supersedes`・`references`）は辿らない
- `status` が `deprecated` の item は、上流としても下流としても対象から外す
- 比べるのは直接の辺だけとする
- `generated.at` と `verified[].at` は、文字列ではなく時刻として読んで比べる。UTC オフセットの違う時刻を並べても、順序を誤らない
- `human:` 以外の actor の `verified` は、基準時刻には数えるが、人の確認には数えない
- 結果は報告に留め、`verified` を自動で加えない

独自の relation を辿るかは
[独自の relation は、再確認待ちを伝播させるかを設定で宣言する](staleness-propagation-declared-for-custom-relations.md)
が定め、この要件では定めない。

## 出典

根拠の決定は次の ADR が持つ。

- [鮮度は上流の relation を辿って下流へ伝播させる](../adr/freshness-propagates-along-upstream-relations.md)
- [human: 以外の verified も受け付け、基準時刻には数えるが人の確認には数えない](../adr/non-human-verified-accepted-not-counted-as-human.md)
- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)

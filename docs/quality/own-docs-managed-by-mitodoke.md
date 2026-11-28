---
id: "QA-ae2f173b-e4b1-412b-8b1f-bcdc38b46170"
type: quality
name: "mitodoke の文書は mitodoke 自身で管理する"
description: "mitodoke のリポジトリは自身の文書を mitodoke で管理し、文書管理の規範を quality item、文書管理の決定を adr として持つ"
specification: |
  The mitodoke repository SHALL manage its own documents with mitodoke. Its solution SHALL
  be mitodoke itself, the norms of document management that the product includes SHALL be
  held as quality items in this repository, and decisions on document management SHALL be
  recorded as adr items in this repository.
specification_ja: |
  mitodoke のリポジトリは、自身の文書を mitodoke で管理しなければならない。solution は
  mitodoke 自身としなければならず、製品が含む文書管理の規範はこのリポジトリの quality
  item として持たなければならず、文書管理の決定はこのリポジトリの adr として記録しなければ
  ならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:45:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:14:19+09:00"
---
# mitodoke の文書は mitodoke 自身で管理する

## 仕様

mitodoke のリポジトリは、自身の文書を mitodoke で管理する。グラフの根の solution は mitodoke
自身で、製品に含める文書管理の規範はこのリポジトリの quality item、文書管理の決定はこの
リポジトリの adr として持つ。

適用先の製品が規範をどう扱うかは、根拠の ADR の決定が持ち、この item は定めない。

この item が縛るのは、mitodoke のリポジトリとその開発の進め方である。製品に同梱する文書管理の
規範には数えない。

## 出典

根拠の決定は次の ADR が持つ。

- [規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する](../adr/norms-kept-in-own-repository.md)

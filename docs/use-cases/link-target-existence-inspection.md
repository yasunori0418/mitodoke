---
id: "UC-3f41572a-3b40-45ad-80cb-57af2bf4595a"
type: use_case
name: "散文のリンクの先の実在を検査する"
description: "利用者が、item の本文に書いた Markdown リンクの先が実在するかを mitodoke に検査させ、リンク切れの報告を受け取る。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:31:01+09:00"
---
# 散文のリンクの先の実在を検査する

> **棄却**: この提案は採らない。`mitodoke check` は散文のリンクの先の実在を検査しない。relation の先の実在は
> sara が検査し、Markdown のリンク切れは既存のリンクチェッカに任せる。決定は
> [散文のリンクの先の実在は check で検査せず、既存のリンクチェッカに任せる](../adr/link-targets-not-inspected.md)
> にある。

## 提案した使われ方

利用者は item を改名したり移したりしたあとに、本文と `specification` に書いた Markdown のリンクの先が
実在するかを、`mitodoke check` に検査させる。リンクの先が無ければ、どの item のどのリンクが切れたかの
報告を受け取る。

## 作らない理由

散文のリンクは relation に当たらず、relation の先の実在は sara がすでに検査している。Markdown のリンク切れを
見つけるのは既存のリンクチェッカの役目で、mitodoke が同じ役目を持つと、コンセプト文書の §4.4 の責務の
局所化から外れる。

## 出典

根拠の決定は次の ADR が持つ。

- [散文のリンクの先の実在は check で検査せず、既存のリンクチェッカに任せる](../adr/link-targets-not-inspected.md)

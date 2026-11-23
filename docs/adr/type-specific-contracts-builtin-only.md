---
id: "ADR-7fa6e2ac-5f12-442a-b2c5-366201ead218"
type: adr
name: "型に固有の契約は組み込みの型だけに働かせる"
description: "frontmatter の形・ID の置き場所・index.md の生成と差分はすべての型に、型に固有の契約は組み込みの型だけに働かせる。"
section: model-config
status: deprecated
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q18）で確定"
justifies:
  - "REQ-fe865691-be47-4ddf-b878-01fc88c0a549"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:14+09:00"
---
# 型に固有の契約は組み込みの型だけに働かせる

> **廃止（2026-11-22）**: 本 ADR の決定は次の後継へ移った。以下の本文は当時の記録として読む。
>
> - 全体 → [組み込みの型・relation・フィールドの名前を条件に持つ契約を、組み込みの型の item だけに働かせる](builtin-only-contracts-closed-by-rule.md)

- ステータス: deprecated
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q18）で確定

## 背景

設定で独自の型と relation を追加できると決めたので
（[独自の型・relation・フィールドは追加だけを許す](custom-definitions-additive-only.md)）、
mitodoke の検査が独自の型をどう扱うかを決める必要があった。

mitodoke の検査には、frontmatter の形や ID の置き場所のように型を問わない契約と、つながりの欠けの
判定、risk の level の導出、test_case とテスト資産の 1:1 のように、組み込みの型名と relation 名を
前提にした契約がある。sara には、型ごとの検査を加える口が無い。

## 決定

frontmatter の形（`generated` と `verified`）、ID の置き場所、index.md の生成と差分は、独自の型を
含むすべての型に働かせる。

つながりの欠けの判定、risk の level の導出、test_case とテスト資産の 1:1 など、型に固有の契約は、
組み込みの型だけに働かせる。

## 根拠

独自の型も index.md と frontmatter の検査の対象に入れないと、一覧に出ない item や `generated` の
無い item ができても気づけない。

型に固有の契約は、組み込みの型と relation を前提にしている。組み込みの定義は設定で変えられない
ので、型に固有の契約を組み込みの型に限れば、独自の型を追加できても検査の契約を製品として固定した
まま保てる。

## 棄却した代替案

### 独自の型と relation には sara の構造の検査だけを働かせる

mitodoke の検査は組み込みの型と relation だけを見て、独自の型と relation には sara の構造の検査
（参照先の有無・循環・接続漏れなど）だけを働かせる案である。独自の型の item が index.md と
frontmatter の検査から外れるので、一覧に出ない item や `generated` の無い item ができても
気づけない。

### 検査の規則も設定で書き、設定した型の組に合わせて動かす

組み込みの型も設定で変えられるようにし、つながりの欠けの規則も設定で書く案である。型の組だけで
なく検査の規則も適用先の製品ごとに変わるので、mitodoke が保証する内容を決めておけない。

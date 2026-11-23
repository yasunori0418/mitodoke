---
id: "ADR-a777cb18-5b0e-4c55-af79-28772e1528cf"
type: adr
name: "組み込みの型・relation・フィールドの名前を条件に持つ契約を、組み込みの型の item だけに働かせる"
description: "組み込みの型・relation・フィールドの名前を条件に持つ契約は組み込みの型の item だけに働かせ、それ以外の契約は独自の型を含むすべての型の item に働かせる。"
section: model-config
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 7 節（inspection-scope-for-custom-types の「など」）"
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "issue #72 の grilling（2026-11-22）で確定。型に固有の契約を組み込みの型だけに働かせる ADR を書き直した"
justifies:
  - "REQ-fe865691-be47-4ddf-b878-01fc88c0a549"
supersedes:
  - "ADR-7fa6e2ac-5f12-442a-b2c5-366201ead218"
references:
  - "ADR-c5dd9c1d-aaa0-44fd-b1d8-e0544f01b0dd"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:22:45+09:00"
---
# 組み込みの型・relation・フィールドの名前を条件に持つ契約を、組み込みの型の item だけに働かせる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [型に固有の契約は組み込みの型だけに働かせる](type-specific-contracts-builtin-only.md), [独自の型・relation・フィールドは追加だけを許す](custom-definitions-additive-only.md), GitHub Issue #72, GitHub Issue #6, GitHub Issue #4
- 起点: issue #72 の grilling（2026-11-22）で確定。型に固有の契約を組み込みの型だけに働かせる ADR を書き直した

## 背景

設定で独自の型と relation を追加できるので
（[独自の型・relation・フィールドは追加だけを許す](custom-definitions-additive-only.md)）、
mitodoke の検査が独自の型をどう扱うかを決める必要がある。

mitodoke の検査には、frontmatter の形や ID の置き場所のように型を問わない契約と、つながりの欠けの
判定や risk の level の導出のように、組み込みの型名と relation 名を前提にした契約がある。sara には、
型ごとの検査を加える口が無い。

組み込みの型だけに働かせる契約を、「つながりの欠けの判定、risk の level の導出、test_case とテスト資産の
1:1 など」と例示で示していたので、どの契約が組み込みの型だけに働くかの範囲が閉じていなかった
（#6 のコメントの 7 節）。

## 決定

組み込みの型・relation・フィールドの名前を条件に持つ契約は、組み込みの型の item だけに働かせる。
それ以外の契約は独自の型を含むすべての型の item に働かせる。

## 根拠

契約がどちらに当たるかは、その契約の条件に組み込みの型・relation・フィールドの名前があるかで決まる。
契約を加えるときも、契約の条件を読めばどちらに当たるかが決まり、例示の一覧を延ばさなくてよい。

組み込みの名前を条件に持つ契約は、組み込みの型と relation を前提にしている。組み込みの定義は設定で
変えられないので、こうした契約を組み込みの型に限れば、独自の型を追加できても検査の契約を製品として
固定したまま保てる。

組み込みの名前を条件に持たない契約は、独自の型にも働く。frontmatter の形（`generated` と `verified`）、
ID の置き場所、index.md の生成と差分の検査はこちらに当たる。独自の型をこれらの検査の対象に入れないと、
一覧に出ない item や `generated` の無い item ができても気づけない。

## 棄却した代替案

### 独自の型と relation には sara の構造の検査だけを働かせる

mitodoke の検査は組み込みの型と relation だけを見て、独自の型と relation には sara の構造の検査
（参照先の有無・循環・接続漏れ）だけを働かせる案である。独自の型の item が index.md と
frontmatter の検査から外れるので、一覧に出ない item や `generated` の無い item ができても
気づけない。

### 検査の規則も設定で書き、設定した型の組に合わせて動かす

組み込みの型も設定で変えられるようにし、つながりの欠けの規則も設定で書く案である。型の組だけで
なく検査の規則も適用先の製品ごとに変わるので、mitodoke が保証する内容を決めておけない。

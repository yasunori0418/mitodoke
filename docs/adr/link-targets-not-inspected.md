---
id: "ADR-2de81580-3d5e-4796-898e-e2af75cea5d7"
type: adr
name: "散文のリンクの先の実在は check で検査せず、既存のリンクチェッカに任せる"
description: "散文の Markdown リンクの先が実在するかを mitodoke check で検査せず、relation の先の実在は sara の検査に、Markdown のリンク切れは既存のリンクチェッカに任せる。"
section: inspection
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 6 節（リンク先の実在の検査）"
origin: "issue #72 の grilling（2026-11-22）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
references:
  - "ADR-12bab183-d9d7-4210-a45b-c4e6568f297b"
  - "ADR-02a75db6-70cd-4fca-bc17-ae8918c4cafd"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:31:12+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:26+09:00"
---
# 散文のリンクの先の実在は check で検査せず、既存のリンクチェッカに任せる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md), [フル ID は frontmatter だけに書き、item にはリンクで触れる](full-ids-in-frontmatter-only.md), [避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](avoid-spelling-check-left-to-adopters.md), GitHub Issue #72, GitHub Issue #6
- 起点: issue #72 の grilling（2026-11-22）で確定

## 背景

item の本文と `specification` ではほかの item へ Markdown のリンクで触れる
（[フル ID は frontmatter だけに書き、item にはリンクで触れる](full-ids-in-frontmatter-only.md)）。その ADR は、
改名でリンクが切れうると書いている。一方で、`mitodoke check` の構造の契約の列挙
（[検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md)）
に、リンク切れは入っていない。`layat #719` も #3 も、リンクの先が実在するかの確認を一回きりにとどめ、
常設の契約テストにしなかった。散文のリンクの先の実在を `check` で検査するかが決まっていなかった。

## 決定

- 散文のリンクの先が実在するかを、`mitodoke check` で検査しない
- relation の先の実在は sara が検査する
- Markdown のリンク切れを見つけることは、既存のリンクチェッカに任せる

## 根拠

散文のリンクは relation に当たらない。relation の先の実在は、sara がすでに検査している。Markdown のリンク切れを
見つけるのは既存のリンクチェッカの役目で、mitodoke が検査を持たないことは、コンセプト文書の §4.4 の
責務の局所化と、避ける綴りの検査を内蔵しない決定
（[避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](avoid-spelling-check-left-to-adopters.md)）に揃う。

## 棄却した代替案

### `check` の構造の契約に、散文のリンクの先の実在を加える

検査の列挙と、その決定を持つ ADR が増える。

### 決めずに、`check` を詰める子の epic に回す

記録にはこの案に固有の不採用の理由は無い。利用者は、検査しないと決めて ADR に記録する形を選んだ。

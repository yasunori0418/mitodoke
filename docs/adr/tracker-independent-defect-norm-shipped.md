---
id: "ADR-fa3a7bde-e4e4-48fb-8c31-588ef3e7dbb6"
type: adr
name: "トラッカーに依らない欠陥運用の規範を製品に含め、欠陥の Issue は検査しない"
description: "トラッカーに依らない欠陥運用の規範を製品に含め、GitHub 用の部分は例として置き、mitodoke は欠陥の Issue を検査しない。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q34）で確定"
justifies:
  - "QA-87b7776a-9ece-42ac-9a56-78daacb42217"
references:
  - "ADR-49733f2e-ed79-480d-bfb9-6361a7f95aed"
  - "ADR-9bec5976-67cd-407a-afa9-3d394a6204ca"
  - "ADR-b0cf66eb-8df5-4fb0-b1ae-a3e7f4255189"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:02+09:00"
---
# トラッカーに依らない欠陥運用の規範を製品に含め、欠陥の Issue は検査しない

- ステータス: stable
- 日付: 2026-11-17
- 関連: [欠陥はグラフに置かず GitHub Issues で管理する](defects-in-github-issues.md), [欠陥 issue のクローズ時にテスト系 item の欠落を追補する](defect-close-backfills-risks.md), [欠陥を既存の RISK / TC に辿れたかで分類して数える](defects-classified-by-risk-foresight.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q34）で確定

## 背景

写した欠陥運用の規範（quality item 1 本と、その根拠の ADR 3 本）は、次の 3 つを定めている。

- 欠陥はグラフに置かず、トラッカーで管理する
- クローズのときに、テスト系の item の欠落を追補する
- 起票の時点で合う risk か test_condition があったかで 2 つに分類し、決まった語彙で記録する

規範の specification は「issue tracker」「the project's fixed vocabulary」と書いていて、GitHub も
ラベルの名前も含まない。GitHub に結びついているのは、Issue の本文の型（見出しは「トレース」と
「feed back」の 2 つ）、ラベル `risk-expected` と `risk-unexpected` の定義と判定の手順（判定に
`git log` と `gh` を使う）、bug フォームの「関連する item」欄である。トレースや分類のラベルを
機械で検査する仕組みは無い。

製品に含める欠陥運用の規範のうち、GitHub に結びついた部分をどう扱うかを決める必要があった。

## 決定

製品には、トラッカーに依らない規範を入れる。GitHub 用の部分（本文の型の見出し「トレース」と
「feed back」、ラベル `risk-expected` と `risk-unexpected` の定義と判定の手順、bug フォームの
「関連する item」欄）は、README か例のディレクトリに例として置く。mitodoke は欠陥の Issue を
検査しない。

## 根拠

規範はすでにトラッカーに依らない書き方なので、そのまま製品に入れられる。

GitHub 用の部分は、用語の避ける綴りの検査を README の例にしたのと同じ形にする。GitHub を使う
適用先の製品はそのまま写せて、ほかのトラッカーを使う適用先の製品は読み替えられる。

mitodoke が欠陥の Issue を検査すると、mitodoke の役割が文書の検査からトラッカーの運用にまで
広がり、責務を明確に分離するというコンセプト文書の設計原則の 9 から外れる。

## 棄却した代替案

### GitHub 用の雛形も製品の一部として配り、gh でラベルや本文の型を検査する

mitodoke の役割が文書の検査からトラッカーの運用にまで広がり、設計原則の 9 から外れる。

### トラッカーに依らない規範だけを入れ、GitHub 用の例は置かない

GitHub で使っている具体的な形が残らない。GitHub を使う適用先の製品が写せる例が無くなる。

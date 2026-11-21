---
id: "ADR-25e0caa5-7da3-4697-865d-4ff72d5a5953"
type: adr
name: "組み込みの型を 12 型にし、すべて必須にする"
description: "製品の組み込みの型は sara_adr を含まない 12 型とし、すべてを必須にして設定では選ばない。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q9・Q13）で確定"
justifies:
  - "REQ-01efc4d0-bec2-44d7-8592-0f7adc81a236"
supersedes:
  - "ADR-c15921a9-7aea-407c-a34b-7465783b1af1"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:14+09:00"
---
# 組み込みの型を 12 型にし、すべて必須にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q9・Q13）で確定

## 背景

mitodoke の model がどの型を持つかを決める必要があった。切り出す前の文書管理の仕組みは、
`solution`・`use_case`・`requirement`・`design`・`risk`・`test_condition`・`test_plan`・
`test_case`・`quality`・`infrastructure`・`adr`・`ubiquitous_term` に `sara_adr` を加えた
13 型を使っていた。このうち `solution` から `test_case` までの 8 型は、concept が述べる要求から
テストまでの連鎖にあたる。

`sara_adr` は、文書管理の仕組みを後で切り出せるように、文書管理の決定を `adr` から分けて記録する
ために設けた型である（[sara 品質管理機構の決定は sara_adr 型に分ける](sara-adr-type-for-doc-process-decisions.md)）。

## 決定

製品の組み込みの型は、`sara_adr` を除く 12 型（`solution`・`use_case`・`requirement`・
`design`・`risk`・`test_condition`・`test_plan`・`test_case`・`quality`・`infrastructure`・
`adr`・`ubiquitous_term`）にする。12 型はすべて必須で、適用先の製品は設定で型を選ばない。

`sara_adr` は製品から消える。`sara_adr` に記録していた文書管理の決定は `adr` に変え、mitodoke の
文書構造を定義する決定として持つ。

## 根拠

型は切り出す前の構成を保ち、`sara_adr` だけを製品から外した。`sara_adr` は切り出しのために
用意した移行用の型なので、切り出した先の mitodoke では役目を終える。mitodoke では、文書管理の
決定も、mitodoke の品質管理の文書構造を定義する決定として `adr` に持てる。

12 型をすべて必須にするので、設定ファイルに使う型を書く必要がない。

受け入れた代償: `sara_adr` に記録していた決定を `adr` に変えると、ID の prefix が `SDR` から
`ADR` に変わる。UUID の部分は保つ。

## 棄却した代替案

### 要求からテストまでの 8 型を必須にし、ほかの 4 型を選べる型にする（推奨だった案）

concept の 8 型は要求からテストまでの連鎖そのものなので、どの適用先の製品にも要る。`quality`・
`infrastructure`・`adr`・`ubiquitous_term` は、適用先の製品によっては規範や用語を item で
持たないこともあるので、設定で使うかどうかを選べる型にする、という案だった。`sara_adr` は
製品に含めない。採らずに、型の構成を保って 12 型をすべて必須にした。

### 8 型だけを持ち、ほかの型は適用先の製品が独自の型として追加する

`quality` は mitodoke 自身の規範に、`adr` は文書管理の決定の記録に使うので、製品の型から
外せない。

### `sara_adr` を含む 13 型をすべて必須にする

一度はこの形に決めたが、`sara_adr` が製品から消えると決めたことで改めた。`sara_adr` は切り出しの
ための移行用の型で、製品には要らない。

### `sara_adr` を残し、文書管理の決定と製品の決定を型で分ける（推奨だった案）

`sara_adr` の型と ID を保てば、記録に残っている ID からそのまま辿れる。文書管理の決定を
`sara_adr` に、mitodoke の実装の決定を `adr` に記録すれば、型を変えずに移せる、という案だった。
`sara_adr` は切り出しのための移行用の型なので、型を残さず `adr` に変えた。ID は prefix だけが
変わり、UUID の部分で辿れる。

### `sara_adr` を、適用先の製品が自分のプロジェクトへの当てはめを決めるときの型として残す

mitodoke 自身の文書管理の決定は `adr` に変え、`sara_adr` は適用先の製品の型として残す案である。
`sara_adr` は移行用の型で、製品からは消すと決めたので、これより踏み込んで型そのものを外した。

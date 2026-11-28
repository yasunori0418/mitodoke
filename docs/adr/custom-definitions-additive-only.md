---
id: "ADR-c5dd9c1d-aaa0-44fd-b1d8-e0544f01b0dd"
type: adr
name: "独自の型・relation・フィールドは追加だけを許す"
description: "設定では型・relation・フィールドのすべてを独自に追加でき、組み込みの定義は削除も変更もできない。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q16・Q18）で確定"
justifies:
  - "REQ-69c1c6b2-bbb7-425b-8256-9f340d9ad36f"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:14+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:24:31+09:00"
---
# 独自の型・relation・フィールドは追加だけを許す

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q16・Q18）で確定

## 背景

model.yaml を設定ファイルから生成すると決めたので
（[model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md)）、
設定で表せない独自の型やフィールドを追加する手段が別に要る。

sara は model.yaml に無い frontmatter のキーをエラーにせずに受け付けるが、検査もせず、
`sara check --format json` の出力にも含めない。sara は model.yaml を部分的に重ねず、全体を
置き換える。そのため mitodoke は、組み込みの定義と独自の定義を合わせた model.yaml を設定から
生成することになる。sara の model.yaml では、型（prefix・ID の書式・親の型・フィールド・張れる
relation）と relation（逆向きの名前・向き・primary か）を自由に定義できる。一方で、「この型は
relation X を必ず持つ」という規則や、型ごとの検査を加える口は sara に無い。

## 決定

型・relation・フィールドのすべてを、設定で独自に追加できる。

組み込みの 12 型と、その relation・フィールドは、設定で削除も変更もできない。独自の定義は
追加だけにし、組み込みの型から独自の型へ張れる relation（`allowed_targets`）を加えることは許す。

`adr` の `origin` は製品の任意フィールドにする。DoD の項目を指す `infrastructure.dod` は製品の
フィールドにせず、使う適用先の製品が設定に書く独自のフィールドにする。

## 根拠

設定で宣言したフィールドは sara の検査と JSON 出力に入るが、宣言の無いキーはどちらにも入らない。
適用先の製品が独自の情報を持つには、宣言する手段が要る。

受け入れた代償: フィールドだけでなく型と relation も追加できるようにした。その代わりに組み込みの
定義を変えられなくし、組み込みの型と relation を前提にした検査の契約を製品として保つ。

`origin` は写した ADR のすべてが持っているので、製品の任意フィールドにすれば値が失われない。

## 棄却した代替案

### 既存の型への独自フィールドの追加だけを許す（推奨だった案）

設定で追加できるのを既存の型へのフィールド（名前・field_type・必須か・placeholder）に限り、
型と relation の追加は許さない案だった。型や relation まで追加できるようにすると、つながりの
欠けや再確認待ちの判定が前提にしている型の組が変わり、検査の契約を製品として決めておけなくなる、
というのが推奨の理由だった。採らずに型と relation の追加も許し、検査の契約は組み込みの定義を
変えられないことで保つ。

### 独自の追加を許さない

適用先の製品が独自の情報を持つ手段が、宣言の無いキーしか無くなる。宣言の無いキーは、sara の検査
にも JSON 出力にも入らない。

### 組み込みの型・relation・フィールドも設定で削除・変更できるようにする

型の組だけでなく検査の規則も適用先の製品ごとに変わるので、mitodoke が保証する内容を決めて
おけない。

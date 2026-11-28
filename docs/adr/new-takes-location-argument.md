---
id: "ADR-b0e9c097-4a1e-41c0-880b-732b4d99fa83"
type: adr
name: "new は置き場所を引数で受け取り、型ごとの置き場所と比べる"
description: "mitodoke new は置き場所を引数で受け取り、設定の型ごとの置き場所と比べて、合わなければ起票を拒む。"
section: commands
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q37）で確定"
justifies:
  - "REQ-a69171a6-7587-4d92-8fce-1cf84d62b36f"
references:
  - "ADR-ba95c0c6-ea15-4e97-95a9-925ac04df58d"
  - "ADR-f900c722-23d9-4dcb-8407-97b4eb98b92a"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:54+09:00"
---
# new は置き場所を引数で受け取り、型ごとの置き場所と比べる

- ステータス: stable
- 日付: 2026-11-17
- 関連: [sara-id を廃止し sara init を包む起票ラッパーで slug のファイル名を適用する](sara-new-wrapper-applies-slug-filename.md), [型と置き場所の一致を構造の契約にし、型ごとの置き場所を設定に持つ](type-location-match-is-structural-contract.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q37）で確定

## 背景

設定に型ごとの置き場所を持つことになり、grilling の途中では「`mitodoke new` も置き場所を型から決める」
と書いていた。これは、今の `sara-new` の引数の形と食い違う。今の `sara-new` は
`sara-new <型> <slug> <置き場所> -- ...` の形で、引数が 3 つ未満なら exit 2 で拒み、テストもこれを
確かめている。スキルの手順も、`sara-new risk <slug> docs/risks -- ...` のように置き場所を渡している。

また、test_condition と test_case の置き場所はテストの区分ごとのディレクトリなので、型だけでは
決まらない。`mitodoke new` が置き場所をどう受け取るかを決め直す必要があった。

## 決定

`mitodoke new` は、今の `sara-new` と同じく置き場所を引数で受け取る（`mitodoke new <型> <slug> <置き場所> -- ...`）。
受け取った置き場所を設定の型ごとの置き場所と比べ、合わなければ起票を拒む。test_condition と
test_case は、置き場所が `docs/test/<区分>/` の形かと、その区分が設定にあるかも確かめる。

grilling の途中で書いた「`mitodoke new` も置き場所を型から決める」は、この決定で置き換える。
確かめる内容は [new は引数の置き場所を型ごとの置き場所と比べ、合わなければ起票を拒む](../requirements/new-location-check.md) が定める。

## 根拠

- 置き場所を引数で受け取ったまま型ごとの置き場所と比べれば、型と置き場所の取り違えを起票のときに見つけられる
- 引数の形が今の `sara-new` と変わらないので、今の `sara-new` を確かめるテストを同じ期待のまま当てられ、スキルの手順も引数の形を書き直さずに済む

## 棄却した代替案

### 置き場所の引数をなくし、型から決める

置き場所の引数をなくして型から決め、test_condition と test_case の区分は `--category <区分>` のような
別の引数で受け取る案。打つ量は減るが、引数の形が変わるので、テストとスキルの手順を書き直すことに
なる。このため採らなかった。

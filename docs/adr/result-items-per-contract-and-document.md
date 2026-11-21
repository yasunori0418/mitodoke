---
id: "ADR-6f2020c5-dc77-44c6-8471-1bd2f72f1f48"
type: adr
name: "check・gap・fresh の item を契約 × 文書の単位にする"
description: "check・gap・fresh の結果は、1 つの文書が 1 つの契約に反したことを item 1 つで表し、kind を契約の名前、key を文書の ID にして、成り立った組は item にしない。"
section: json-output
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q47）で確定"
justifies:
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:18+09:00"
---
# check・gap・fresh の item を契約 × 文書の単位にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q47）で確定

## 背景

mitodoke の `--json` は outturn のエンベロープにすると決めた。outturn では結果を item の配列で
表し、item 1 つは error を 1 つだけ持てる（警告は複数持てる）。item の id は `{kind, key}` から
導く値で、実行をまたいで変わらない。

outturn の check の手本は、前提条件 1 つを item 1 つで表している。写した script の `gap` と
`fresh` に当たる JSON は、節ごとに、該当した文書の ID・名前・ファイルを並べている。

検査の結果を、何の単位で item にするかを決める必要があった。`export` は検査ではないので、
この決定には含めない。

## 決定

`check`・`gap`・`fresh` の item は、契約 × 文書を単位にする。1 つの文書が 1 つの契約に反した
こと（`gap` と `fresh` では、1 つの文書が 1 つの節に該当したこと）を、item 1 つで表す。`kind` は
契約の名前、`key` は文書の ID にする。成り立った組は item にしない。

## 根拠

違反の 1 件ずつが実行をまたいで同じ id を持つので、前回の結果と比べて、直った違反と新しい違反を
見分けられる。outturn の item が error を 1 つしか持てない制約にも、そのまま合う。

成り立った組を item にしないのは、文書の数と契約の数の積だけ item が並ぶのを避けるためである。
outturn の仕様は、成り立った前提条件をすべて並べることまでは求めていないと読んだ。

## 棄却した代替案

### 契約を単位にする

契約ごとに item を 1 つ出し、反した文書を item の `info` に並べる案で、outturn の check の手本と
同じ形になる。違反した文書の一覧が `info` の中に入るので、outturn の id で 1 件ずつを指せない。

### 文書を単位にする

文書ごとに item を 1 つ出す案。1 つの文書が 2 つ以上の契約に反したとき、error を 1 つしか
持てない item では表しきれない。

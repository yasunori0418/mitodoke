---
id: "ADR-7bef3ffc-d2db-4da1-98d0-3678f57c3ea6"
type: adr
name: "サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける"
description: "mitodoke の CLI のサブコマンドは、開発に使う script の名前から接頭辞を外した名前で、機能ごとに分ける。"
section: commands
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q25）で確定"
justifies:
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
references:
  - "ADR-f3d7ea3d-2959-41ec-8170-9678815196d0"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
---
# サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける

- ステータス: stable
- 日付: 2026-11-17
- 関連: [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](single-cli-with-subcommands.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q25）で確定

## 背景

mitodoke の開発では、起票・つながりの欠けの報告・再確認待ちの報告・index.md の生成・対応表の生成を、
`sara-new`・`sara-gap`・`sara-fresh`・`okf-index`・`test-doc-matrix` という別々の script で行っている。
grilling のそれまでの決定で、CLI が持つ機能が揃った。script の機能に加えて、設定からの model.yaml の生成、
人の確認の記録、item の一覧の JSON の出力、検査をまとめて実行する機能が要る。

これらを 1 つの CLI のサブコマンドとして、どういう名前でどう分けるかを決める必要があった。スキルは
script の名前で手順を書いているので、名前の決め方はスキルの書き換えの量にも関わる。

## 決定

今の script の名前から `sara-` などを外した名前で、機能ごとにサブコマンドを分ける。サブコマンドは
`mitodoke new`・`gap`・`fresh`・`index`・`matrix`・`model`・`verify`・`export`・`check` の 9 つとする。

- `index` と `model` は、生成した結果とコミットされたファイルの差分を確かめる `--check` を持つ
- 報告と生成のサブコマンドは `--json` を持つ
- `check` は、構造の契約・つながりの欠け・見直しの義務の検査をまとめて実行し、設定の強さで失敗か報告かを決める

サブコマンドごとの機能は、[サブコマンドは new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md) が定める。

## 根拠

- 今の script と名前が 1 対 1 で対応するので、スキルの書き換えは、`sara-new` を `mitodoke new` に置き換えるように名前を置き換えることが中心になる。ただし、スキルが JSON を読む箇所では、名前に加えて読むパスも直す
- 今の script を確かめるテストを、対応するサブコマンドにそのまま当てられる
- 動詞でまとめても、サブコマンドの数は減らず、打つ語が 1 つ増えるだけである

## 棄却した代替案

### 報告と生成を動詞でまとめる

報告を `mitodoke report gap`・`mitodoke report fresh`、生成を `mitodoke generate index`・`generate matrix`・`generate model` にまとめ、`new`・`verify`・`export`・`check` はそのままにする案。サブコマンドの数は減らず、打つ語が 1 つ増えるだけなので採らなかった。今の script との名前の対応も崩れる。

---
id: "ADR-5447bb3f-3863-48ac-a7f3-83f4e49ca14b"
type: adr
name: "決定は adr に、作業は Issue に記録する"
description: "grilling の決定は mitodoke のリポジトリの adr に、実装の作業は mitodoke の Issue に記録すると決める。"
section: migration-records
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q31）で確定"
justifies:
  - "QA-030f926b-5ae7-4543-b8cb-e66aae5e2b5e"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:34:15+09:00"
---
# 決定は adr に、作業は Issue に記録する

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q31）で確定

## 背景

2026-11-17 の grilling で決めたことと、これからの実装の作業を、どこに記録するかを決める必要が
あった。

grilling の記録は、git の無視対象のディレクトリにある。mitodoke の構想の起点だった layat #500 は
open のままで、本文は 2026-10-20 の起票時のものである。その後、ファイル名が UUID 付きから slug
だけに変わるなど、本文といまの運用が食い違っている。mitodoke のリポジトリは公開されていて Issue も
有効だが、まだ 1 件も無かった。mitodoke へコピーする規範には「ADR は 1 本に 1 つの決定を書く」と
いうものがあり、決定は 30 件ほどあった。

## 決定

- 決定は、mitodoke のリポジトリに `adr` として記録する。型と置き場所は、コピーする文書管理の決定と
  同じにする
- 実装の作業は、mitodoke の Issue に起票する
- layat #500 には、mitodoke へ移ったことと決定の一覧へのリンクをコメントし、本文は書き換えない
- 記録に取りかかるのは、grilling が終わり、共有の理解を確かめたあとにする

## 根拠

mitodoke の設計の決定は、mitodoke のグラフの `adr` として持つのが筋である。`adr` にしておけば、
決定から規範や設計の item へ `justifies` を張れて、あとで決定を見直したときに、影響を受ける item を
辿れる。

## 棄却した代替案

### layat #500 の本文を書き直し、作業の sub-issue も layat に起票する

mitodoke の作業が layat の Issue に分かれ、コードと作業の記録が別のリポジトリに置かれる。

### 決定を mitodoke の Issue か 1 枚の文書にまとめ、ADR にしない

決定から item へ `justifies` を張れず、決定を見直したときに影響を受ける item を辿れない。

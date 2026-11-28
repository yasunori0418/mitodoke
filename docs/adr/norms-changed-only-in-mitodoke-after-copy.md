---
id: "ADR-7cb9393c-6c20-4422-8bcd-2f6a0f95271c"
type: adr
name: "文書管理の規範と決定は、写した時点から mitodoke だけで変える"
description: "layat から写した時点から、文書管理の規範と決定を mitodoke だけで変えると決める。"
section: migration-records
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q32）で確定"
justifies:
  - "QA-febe2e03-f845-40c2-8359-8ebaefb71ddd"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:44+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:34:07+09:00"
---
# 文書管理の規範と決定は、写した時点から mitodoke だけで変える

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q32）で確定

## 背景

文書管理の規範と決定は、layat から mitodoke へコピーし、layat の側はいまのまま残す。コピーの
あと、規範と決定をどちらで変えていくかを決める必要があった。

layat では、2026-11-10 以降の 1 週間で、文書管理の決定を変えたコミットが 35 件、quality item を
変えたコミットが 33 件あった。写した shell script は layat と同期しない。layat は mitodoke へ
移行するまで、いまの script を使い続ける。

## 決定

- コピーした時点（layat の `97ec53ae`）から、文書管理の規範と決定の変更は mitodoke だけで行う
- layat の作業中に気づいたものも mitodoke で変える。その前に mitodoke の Issue に起票する
- layat のコピー元の文書は、移行まで変えない

## 根拠

コピー元の規範は、いまも頻繁に変わっている。変更の場所を mitodoke の 1 つに決めれば、同じ規範を
2 か所で変えて手で合わせることにならず、どちらが新しいかが分からなくなることも無い。写した shell
script を layat と同期しないことにも揃う。

## 棄却した代替案

### layat でも変えてよく、mitodoke へは手で取り込む

同じ規範を 2 か所で変えて手で合わせることになり、どちらが新しいかが分からなくなる。

### layat の移行まで layat で変え続け、mitodoke はそれに追従する

mitodoke の規範が layat の変更を待つことになり、mitodoke を完成させる作業が止まる。

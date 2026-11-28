---
id: "ADR-624291a9-2be5-44c8-8dbc-b70784e69222"
type: adr
name: "sara は必要なときに上げ、Cargo.lock と flake の input を同じタグに揃える"
description: "sara のタグは要る機能や修正が入ったときに上げ、Cargo.lock と flake の input を同じタグへ揃えると決める。"
section: distribution
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q35）で確定"
justifies:
  - "QA-927c1c38-06b7-4980-baf1-d354a9470203"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:51+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:41:46+09:00"
---
# sara は必要なときに上げ、Cargo.lock と flake の input を同じタグに揃える

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q35）で確定

## 背景

組み込む sara-core と配る sara の CLI は、同じタグに固定することにした。そのタグをいつ、どう
上げるかを決める必要があった。

sara は 0.x で、0.12.0 の CHANGELOG には破壊的変更が 7 件ある。sara-core の README の使用例は、
今の crate では公開されていない名前を import している。`yasunori0418/sara` は upstream へ
pull request を出すための fork で、独自の変更は無い。

## 決定

- sara は必要なときに上げる。mitodoke に要る機能や修正が sara の新しいタグに入ったときに上げる
- 上げるときは、Cargo.lock と flake の input を同じタグへ揃え、その pull request で受け入れテストと
  mitodoke 自身の `mitodoke check` を成功させる
- upstream に無い修正は、fork から upstream へ pull request を出し、取り込まれたタグで上げる

## 根拠

0.x の sara は破壊的変更が多く、上げるたびに sara-core を使うモジュールを直すことになる。上げる
理由があるときにまとめて追うほうが、手間が少なくなる。

## 棄却した代替案

### 新しいタグが出るたびに上げる

依存の更新を知らせるツールで pull request を作る案。mitodoke に関係の無い変更でも、毎回 API への
追従が要る。

---
id: "ADR-8f53ec2f-d2ff-414f-bee4-4ae0a8b25cf3"
type: adr
name: "workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する"
description: "mitodoke 自身の開発で、workflow に最小権限の permissions を宣言し、外部の action をコミット SHA で固定する規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-8f4da12f-6ce7-4d78-9b59-fb67891e8f71"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:47:19+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:21+09:00"
---
# workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75, GitHub Issue #78
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI を実装する前に、mitodoke 自身の
開発の規範を決める必要があった。#6 のコメントは、action の固定と `permissions` がどの open な Issue
にも割り当てられていないと書いていた。最小権限の `permissions` を求める規範は
mitodoke にまだ無い。

mitodoke の今の workflow は `permissions` のキーを持たず、外部の action はコミット SHA で固定している。

## 決定

規範 [workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する](../quality/workflows-least-privilege-and-pinned-actions.md)
を起こす。workflow は最小権限の `permissions` を宣言し、外部の action はコミット SHA で固定する。

workflow の書き換えはこの規範では行わない。CI を実装する
子の epic A（テストの区分の `foundation` に当たる範囲）が行う。

## 根拠

- この規範はどの open な Issue にも割り当てられておらず、同じことを求める規範も mitodoke に無いので、
  ここで起こす
- 規範を先に書いておけば、子の epic は CI を実装するときに、何を満たせばよいかを item から読める

## 棄却した代替案

### 規範を起こさず、#78 が子の epic A に割り当てる

この規範を item にせず、子の epic を起こす #78 が子の epic A に割り当てる案。子の epic A が CI を
実装するときに、何を満たせばよいかを item から読めない。

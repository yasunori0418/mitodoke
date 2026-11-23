---
id: "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
type: requirement
name: "verify は端末での人の入力があるときだけ人の確認を記録する"
description: "mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を記録し、端末の無い実行では拒む。"
specification: |
  mitodoke verify <item> SHALL write an entry with the actor `human:<id>` and the current time to the
  verified record of the item only when a person enters a confirmation at a terminal. When the
  command is run without a TTY, such as from CI or an agent, mitodoke verify SHALL refuse to write
  the record. mitodoke verify SHALL write the time as a time to the second with the local UTC
  offset of the environment in which it runs (for example `2026-11-23T13:45:23+09:00`), in the
  same form as mitodoke new writes `generated.at`.
specification_ja: |
  mitodoke verify <item> は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ
  要素を item の verified に書かなければならない。CI やエージェントからのような TTY の無い実行では、
  mitodoke verify は記録を書くことを拒まなければならない。mitodoke verify は、時刻を、実行した環境の
  ローカルの UTC オフセットを付けた秒までの形（例 `2026-11-23T13:45:23+09:00`）で、mitodoke new が
  `generated.at` に書く形と同じ形で書かなければならない。
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:49:01+09:00"
---
# verify は端末での人の入力があるときだけ人の確認を記録する

## 仕様

- `mitodoke verify <item>` は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ要素を item の `verified` に書く
- CI やエージェントからのような TTY の無い実行では、記録を書くことを拒む
- 時刻は、実行した環境のローカルの UTC オフセットを付けた秒までの形（例 `2026-11-23T13:45:23+09:00`）で書く。`mitodoke new` が `generated.at` に書く形と同じにする

## 出典

根拠の決定は次の ADR が持つ。

- [verify は、端末で人が確認を入力したときだけ確認の記録を書く](../adr/verify-records-human-only-from-terminal.md)
- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)

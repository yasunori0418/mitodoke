---
id: "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
type: requirement
name: "verify は端末での人の入力があるときだけ人の確認を記録する"
description: "mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を記録し、端末の無い実行では拒む。"
specification: |
  mitodoke verify <item> SHALL write an entry with the actor `human:<id>` and the current time to the
  verified record of the item only when a person enters a confirmation at a terminal. When the
  command is run without a TTY, such as from CI or an agent, mitodoke verify SHALL refuse to write
  the record.
specification_ja: |
  mitodoke verify <item> は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ
  要素を item の verified に書かなければならない。CI やエージェントからのような TTY の無い実行では、
  mitodoke verify は記録を書くことを拒まなければならない。
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:19+09:00"
---
# verify は端末での人の入力があるときだけ人の確認を記録する

## 仕様

- `mitodoke verify <item>` は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ要素を item の `verified` に書く
- CI やエージェントからのような TTY の無い実行では、記録を書くことを拒む

## 出典

根拠の決定は次の ADR が持つ。

- [verify は、端末で人が確認を入力したときだけ確認の記録を書く](../adr/verify-records-human-only-from-terminal.md)

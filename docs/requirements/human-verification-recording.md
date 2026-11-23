---
id: "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
type: requirement
name: "verify は端末での人の入力があるときだけ人の確認を記録する"
description: "mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を記録し、端末からの実行でないときは拒む。"
specification: |
  mitodoke verify <item> SHALL write an entry with the actor `human:<id>` and the current time to the
  verified record of the item only when a person enters a confirmation at a terminal. When the
  command is not run from a terminal, mitodoke verify SHALL refuse to write the record. A run from
  a terminal SHALL mean a run in which both the standard input and the standard output are
  terminals, and mitodoke verify SHALL use the same judgement as mitodoke new. mitodoke SHALL NOT
  provide an environment variable that disables this judgement. mitodoke verify SHALL write the time as a time to the second with the local UTC
  offset of the environment in which it runs (for example `2026-11-23T13:45:23+09:00`), in the
  same form as mitodoke new writes `generated.at`.
specification_ja: |
  mitodoke verify <item> は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ
  要素を item の verified に書かなければならない。端末からの実行でないときは、mitodoke verify は記録を
  書くことを拒まなければならない。端末からの実行は、標準入力と標準出力の両方が端末である実行でなければ
  ならず、mitodoke verify は mitodoke new と同じ判定を使わなければならない。mitodoke は、この判定を外す
  環境変数を持ってはならない。mitodoke verify は、時刻を、実行した環境の
  ローカルの UTC オフセットを付けた秒までの形（例 `2026-11-23T13:45:23+09:00`）で、mitodoke new が
  `generated.at` に書く形と同じ形で書かなければならない。
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:50:48+09:00"
---
# verify は端末での人の入力があるときだけ人の確認を記録する

## 仕様

- `mitodoke verify <item>` は、端末で人が確認を入力したときだけ、actor が `human:<id>` で現在時刻を持つ要素を item の `verified` に書く
- 端末からの実行でないときは、記録を書くことを拒む
- 端末からの実行は、標準入力と標準出力の両方が端末である実行を指す。`mitodoke new` と同じ判定を使う。判定を外す環境変数は持たない
- 時刻は、実行した環境のローカルの UTC オフセットを付けた秒までの形（例 `2026-11-23T13:45:23+09:00`）で書く。`mitodoke new` が `generated.at` に書く形と同じにする

## 出典

根拠の決定は次の ADR が持つ。

- [verify は、端末で人が確認を入力したときだけ確認の記録を書く](../adr/verify-records-human-only-from-terminal.md)
- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)
- [端末からの実行は stdin と stdout の両方が端末であることで判定する](../adr/terminal-run-judged-by-stdin-and-stdout.md)

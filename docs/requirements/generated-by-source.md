---
id: "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
type: requirement
name: "generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする"
description: "mitodoke new は generated.by を MITODOKE_GENERATED_BY か --by から取り、どちらも無いときは端末からの実行に限り human:<id> を書き、端末の無い実行では起票を拒む。"
specification: |
  mitodoke new SHALL take the value of generated.by from the environment variable
  MITODOKE_GENERATED_BY or the argument --by. When neither is given, mitodoke new SHALL, only when it
  is run from a terminal, build `human:<id>` from the output of the command defined in the
  configuration for obtaining `<id>`, and SHALL write it as generated.by. When neither is given and
  the command is run without a terminal, such as from an agent or CI, mitodoke new SHALL refuse to
  create the item. mitodoke new SHALL write `generated.at` as a time to the second with the local
  UTC offset of the environment in which it runs (for example `2026-11-23T13:45:23+09:00`), in
  the same form as mitodoke verify writes.
specification_ja: |
  mitodoke new は、generated.by の値を環境変数 MITODOKE_GENERATED_BY か引数 --by から取らなければ
  ならない。どちらも無いときは、端末からの実行に限り、設定に定義した `<id>` を取るコマンドの出力から
  `human:<id>` を作り、generated.by に書かなければならない。どちらも無く、エージェントや CI のような
  端末の無い実行であるときは、mitodoke new は起票を拒まなければならない。mitodoke new は、
  `generated.at` を、実行した環境のローカルの UTC オフセットを付けた秒までの形（例
  `2026-11-23T13:45:23+09:00`）で、mitodoke verify と同じ形で書かなければならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:49:01+09:00"
---
# generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする

## 仕様

- `mitodoke new` は、`generated.by` の値を環境変数 `MITODOKE_GENERATED_BY` か引数 `--by` から取る
- どちらも無いときは、端末からの実行に限り、設定に定義した `<id>` を取るコマンドの出力から `human:<id>` を作り、`generated.by` に書く
- どちらも無く、エージェントや CI のような端末の無い実行であるときは、起票を拒む
- `generated.at` は、実行した環境のローカルの UTC オフセットを付けた秒までの形（例 `2026-11-23T13:45:23+09:00`）で書く。`mitodoke verify` が書く形と同じにする

`<id>` を取るコマンドは [人の確認に書く識別子は設定のコマンドの出力から取り、不正な出力では何も書かない](human-id-command.md) と同じものを使う。

## 出典

根拠の決定は次の ADR が持つ。

- [generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする](../adr/generated-by-from-env-or-flag.md)
- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)

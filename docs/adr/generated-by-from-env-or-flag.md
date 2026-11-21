---
id: "ADR-83279925-6de1-44cd-a4bc-6923b0ed900b"
type: adr
name: "generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする"
description: "mitodoke new は generated.by を MITODOKE_GENERATED_BY か --by で受け取り、どちらも無いときは端末からの実行に限り human:<id> を作り、端末の無い実行では起票を拒む。"
section: commands
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q29）で確定"
justifies:
  - "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
references:
  - "ADR-9a646576-31bd-4cea-996d-54993ff2b8fa"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:37+09:00"
---
# generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: [item に生成者・確認の記録・期限を持たせる](generated-verified-stale-after.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q29）で確定

## 背景

`mitodoke new` は、起票のときに `generated.by`（誰が作ったか）を書く。その値をどこから取るかを決める
必要があった。

今の `sara-new` は、環境変数 `SARA_NEW_GENERATED_BY` が無いか空なら起票を拒み（exit 2）、`"`・`\`・改行を
含む値も拒む。スキルは、エージェントには `claude-code/<モデル ID>` を、人には `human:<GitHub の ID>` を
設定するよう書いている。[verify は、端末で人が確認を入力したときだけ確認の記録を書く](verify-records-human-only-from-terminal.md)
では、端末の有無で人の実行かを判断すると決めた。[人の識別子は、設定に定義したコマンドの出力から取る](human-id-from-configured-command.md)
で、`<id>` を取るコマンドを設定に定義すると決めたので、`generated.by` にも同じコマンドを使う選択肢ができた。

## 決定

`mitodoke new` は、`generated.by` を環境変数 `MITODOKE_GENERATED_BY` か引数 `--by` で受け取る。
どちらも無いときは、端末からの実行に限り、設定に定義した `<id>` を取るコマンドの出力から `human:<id>` を作る。
端末が無い実行（エージェントや CI）では起票を拒む。TTY は疑似端末で越えられるので、この判断は人の実行の
証明ではない。

取り方の規範は [generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする](../requirements/generated-by-source.md) が定める。

## 根拠

- 人は、`<id>` を取るコマンドを設定しておけば、起票のたびに環境変数を設定しなくて済む
- エージェントが実行するコマンドには端末が無いので、環境変数を設定し忘れると起票が拒まれる。これが、エージェントの作った item を人の作ったものとして記録しないための仕組みになる

## 棄却した代替案

### 環境変数か引数で必ず渡す

環境変数か引数で必ず渡し、どちらも無ければ起票を拒む案（今の `sara-new` と同じ）。確実だが、人も起票の
たびに `human:<id>` を設定することになるので採らなかった。

### 端末の有無を問わず、設定のコマンドから作る

環境変数も引数も無いときは、端末の有無を問わず、設定のコマンドから `human:<id>` を作る案。エージェントが
環境変数を設定し忘れると、エージェントの作った item が人の作ったものとして記録されるので採らなかった。

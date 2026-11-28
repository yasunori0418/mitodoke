---
id: "REQ-ecc41a24-b465-4ab9-ba1b-e56dc5f8a17c"
type: requirement
name: "設定ファイルは作業ディレクトリから読み、作業ディレクトリを workingDirectory に、設定ファイルのパスと暗黙の入力を info に記録する"
description: "mitodoke は --config を省いたとき作業ディレクトリの設定ファイルだけを読み、作業ディレクトリをエンベロープの workingDirectory に出し、読んだ設定ファイルの絶対パスと、環境変数と設定のコマンドから取った値をトップレベルの info に記録する。"
specification: |
  mitodoke SHALL read the configuration file given by --config. When --config is omitted,
  mitodoke SHALL read the configuration file in the working directory and SHALL NOT search
  parent directories for it. When a subcommand writes a result envelope, mitodoke SHALL output
  the working directory at execution time in the `workingDirectory` field of the envelope and
  SHALL NOT write it in `info`. mitodoke SHALL record the absolute path of the configuration file
  it read in the top-level `info` of the envelope, both when --config is given and when it is
  omitted. When mitodoke takes a value from the environment variable MITODOKE_GENERATED_BY or
  builds the identifier of a person from the output of the command in the configuration, it SHALL
  also record that value in the top-level `info`. When both MITODOKE_GENERATED_BY and --by are
  given, mitodoke SHALL NOT record the value of MITODOKE_GENERATED_BY in `info`, because it uses
  the value of --by and does not take the value from the environment variable. The keys of `info` SHALL be in camelCase.
specification_ja: |
  mitodoke は、--config で指定された設定ファイルを読まなければならない。--config を省いたときは、
  作業ディレクトリの設定ファイルを読まなければならず、上のディレクトリへ探してはならない。
  サブコマンドが結果エンベロープを出すとき、mitodoke は、実行時の作業ディレクトリをエンベロープの
  `workingDirectory` に出さなければならず、`info` に書いてはならない。mitodoke は、読んだ設定ファイルの
  絶対パスを、--config で指したときも省いたときも、エンベロープのトップレベルの `info` に記録しなければ
  ならない。mitodoke は、環境変数 MITODOKE_GENERATED_BY から値を取ったときと、設定のコマンドの出力から人の
  識別子を作ったときは、その値もトップレベルの `info` に記録しなければならない。MITODOKE_GENERATED_BY と --by の両方が
  あるときは、mitodoke は --by の値を使い、環境変数から値を取らないので、MITODOKE_GENERATED_BY の値を
  `info` に記録してはならない。`info` のキーは、キャメルケースで
  なければならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T20:22:00+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:03:19+09:00"
---
# 設定ファイルは作業ディレクトリから読み、作業ディレクトリを workingDirectory に、設定ファイルのパスと暗黙の入力を info に記録する

## 仕様

mitodoke は、`--config` で指定された設定ファイルを読む。`--config` を省いたときは作業
ディレクトリの設定ファイルを読み、上のディレクトリへは探さない。

`--json` で結果エンベロープを出すときは、次のように記録する。

- 実行時の作業ディレクトリは、エンベロープの `workingDirectory` に出し、`info` には書かない
- 読んだ設定ファイルの絶対パスは、`--config` で指したときも省いたときも、トップレベルの `info` に記録する
- 環境変数 `MITODOKE_GENERATED_BY` から値を取ったときと、設定のコマンドの出力から人の識別子を作った
  ときは、その値もトップレベルの `info` に記録する。`MITODOKE_GENERATED_BY` と `--by` の両方があるときは
  `--by` の値を使い、環境変数から値を取らないので、環境変数の値は `info` に記録しない
- `info` のキーは、outturn のフィールドに合わせてキャメルケースにする

outturn の §8 は、作業ディレクトリを `workingDirectory` で出すことと、暗黙の入力の解決結果をトップレベルの
`info` に記録することを求めている。出力に残ったこれらの値で、同じ条件で実行し直せる。

## 出典

根拠の決定は次の ADR が持つ。

- [作業ディレクトリは workingDirectory に出し、設定ファイルのパスは常に info に記録する](../adr/working-directory-field-and-config-path-always-recorded.md)

---
id: "REQ-ecc41a24-b465-4ab9-ba1b-e56dc5f8a17c"
type: requirement
name: "設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する"
description: "mitodoke は --config を省いたとき作業ディレクトリの設定ファイルだけを読み、実行時の作業ディレクトリと読んだ設定ファイルの絶対パスをエンベロープのトップレベルの info に記録する。"
specification: |
  mitodoke SHALL read the configuration file given by --config. When --config is omitted,
  mitodoke SHALL read the configuration file in the working directory and SHALL NOT search
  parent directories for it. When a subcommand writes a result envelope, mitodoke SHALL record
  the absolute path of the working directory at execution time and the absolute path of the
  configuration file it read in the top-level info of the envelope. This is the form in which
  mitodoke satisfies the standalone requirement of section 8 of outturn.
specification_ja: |
  mitodoke は、--config で指定された設定ファイルを読まなければならない。--config を省いたときは、
  作業ディレクトリの設定ファイルを読まなければならず、上のディレクトリへ探してはならない。
  サブコマンドが結果エンベロープを出すとき、mitodoke は、実行時の作業ディレクトリの絶対パスと、
  読んだ設定ファイルの絶対パスを、エンベロープのトップレベルの info に記録しなければならない。
  これが、mitodoke が outturn の §8 の standalone を満たす形である。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:53:25+09:00"
---
# 設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する

## 仕様

mitodoke は、`--config` で指定された設定ファイルを読む。`--config` を省いたときは作業
ディレクトリの設定ファイルを読み、上のディレクトリへは探さない。

`--json` で結果エンベロープを出すときは、実行時の作業ディレクトリと、読んだ設定ファイルを、
どちらも絶対パスでエンベロープのトップレベルの `info` に記録する。出力に残ったこの 2 つで、
同じ条件で実行し直せる。

これが、mitodoke が outturn の §8 の `standalone` を満たす形である。この形は §8 の文言どおりでは
なく、outturn に適合していると言えるかは、outturn #66 の結論で決まる。

## 出典

根拠の決定は次の ADR が持つ。

- [設定ファイルは作業ディレクトリのものだけを読み、読んだパスを info に記録する](../adr/config-read-from-working-directory-and-recorded.md)

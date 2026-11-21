---
id: "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
type: requirement
name: "1 つの CLI が、サブコマンドごとに入力・出力・exit code を定める"
description: "mitodoke は文書の検査・起票・生成を 1 つの CLI のサブコマンドとして持ち、サブコマンドごとに入力・出力・exit code を定める"
specification: |
  mitodoke SHALL provide the inspection of documents against each contract, the creation of
  items and the generation of derived files as subcommands of a single CLI, and SHALL hold
  that logic inside the CLI rather than in separate executables or shell scripts. The CLI
  SHALL delegate to external tools only the work that a dedicated tool already performs,
  such as sara and git. Each subcommand SHALL define its input, its output and its exit
  code, so that the subcommands can be composed with other tools from outside.
specification_ja: |
  mitodoke は、契約ごとの文書の検査・item の起票・派生するファイルの生成を 1 つの CLI の
  サブコマンドとして提供しなければならず、その処理を別の実行ファイルや shell script では
  なく CLI の中に持たなければならない。CLI が外部ツールに任せるのは、sara や git のように
  専用のツールがすでに担っている仕事だけでなければならない。各サブコマンドは、外からほかの
  ツールと組み合わせられるように、入力・出力・exit code を定めなければならない。
section: product-scope
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:50:32+09:00"
---
# 1 つの CLI が、サブコマンドごとに入力・出力・exit code を定める

## 仕様

mitodoke の機能は、1 つの CLI のサブコマンドとして提供する。文書の契約ごとの検査、item の
起票、index.md などの派生するファイルの生成は、どれも同じ CLI の中にあり、同じモデル・設定・
frontmatter を 1 か所で読む。

外部ツールに任せるのは、すでに専用の仕事をしているツール（sara と git など）に限る。それ以外の
検査・起票・生成を、別の実行ファイルや shell script として CLI の外に置かない。

各サブコマンドは、受け取る入力・出す出力・exit code を定める。利用者と CI は、この取り決めを
頼りにサブコマンドを外から組み合わせる。サブコマンドの分け方と名前、出力の形、exit code の
値は、それぞれの要件が定める。

## 出典

根拠の決定は次の ADR が持つ。

- [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](../adr/single-cli-with-subcommands.md)

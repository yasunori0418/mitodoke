---
id: "REQ-fa6eaf70-fdfb-4a93-9922-37ec17a625e6"
type: requirement
name: "人の確認に書く識別子は設定のコマンドの出力から取り、不正な出力では何も書かない"
description: "mitodoke verify は、human:<id> の <id> を設定に定義したコマンドの出力から取り、出力が不正なときやコマンドが失敗したときは何も書かずにエラーにする。"
specification: |
  The configuration file mitodoke.yaml SHALL be able to define the command that yields the `<id>` of
  `human:<id>`. After the terminal confirmation, mitodoke verify SHALL run that command in the
  environment of the person running it and SHALL use its output as `<id>`. When the output is empty,
  spans more than one line, or contains a double quote, a backslash, or a newline, or when the
  command fails, mitodoke verify SHALL write nothing and SHALL end with an error.
specification_ja: |
  設定ファイル mitodoke.yaml には、`human:<id>` の `<id>` を取るコマンドを定義できなければならない。
  mitodoke verify は、端末での確認のあと、そのコマンドを実行する人の環境で実行し、その出力を
  `<id>` にしなければならない。出力が空のとき、複数行のとき、二重引用符・バックスラッシュ・改行を
  含むとき、またはコマンドが失敗したときは、mitodoke verify は何も書かずにエラーで終わらなければ
  ならない。
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:19+09:00"
---
# 人の確認に書く識別子は設定のコマンドの出力から取り、不正な出力では何も書かない

## 仕様

- `mitodoke.yaml` には、`human:<id>` の `<id>` を取るコマンドを定義できる（例: `gh api user --jq .login`、`git config user.name`）
- `mitodoke verify` は、端末での確認のあと、そのコマンドを実行する人の環境で実行し、その出力を `<id>` にする
- 出力が空のとき、複数行のとき、`"`・`\`・改行を含むとき、またはコマンドが失敗したときは、何も書かずにエラーで終わる

## 出典

根拠の決定は次の ADR が持つ。

- [人の識別子は、設定に定義したコマンドの出力から取る](../adr/human-id-from-configured-command.md)

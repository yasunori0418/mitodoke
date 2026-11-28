---
id: "REQ-ba6cb998-94a0-4806-bd9a-db9a83484991"
type: requirement
name: "init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、既存の mitodoke.yaml を上書きしない"
description: "mitodoke init は、初期の mitodoke.yaml と、設定が型ごとに持つ置き場所のディレクトリを作り、mitodoke.yaml がすでにあるときは上書きせずに拒み、文書管理の規範を適用先の製品へ複製しない。"
specification: |
  mitodoke init SHALL create an initial `mitodoke.yaml` and the directories of the locations that
  the configuration holds for each type. When `mitodoke.yaml` already exists, mitodoke init SHALL
  refuse without overwriting it. mitodoke init SHALL NOT copy the document-management norms of
  mitodoke into the adopting product.
specification_ja: |
  mitodoke init は、初期の `mitodoke.yaml` と、設定が型ごとに持つ置き場所のディレクトリを作らなければ
  ならない。`mitodoke.yaml` がすでにあるときは、mitodoke init は上書きせずに拒まなければならない。
  mitodoke init は、mitodoke の文書管理の規範を適用先の製品へ複製してはならない。
section: commands
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:22:45+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:57:52+09:00"
---
# init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、既存の mitodoke.yaml を上書きしない

## 仕様

- `mitodoke init` は、初期の `mitodoke.yaml` と、設定が型ごとに持つ置き場所のディレクトリを作る
- `mitodoke.yaml` がすでにあるときは、上書きせずに拒む
- mitodoke の文書管理の規範は適用先の製品へ複製しない

model.yaml と `sara.toml` の生成は、[model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる](model-and-sara-toml-generated-from-config.md) が定める。

## 出典

根拠の決定は次の ADR が持つ。

- [init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、規範は複製しない](../adr/init-creates-config-and-directories.md)

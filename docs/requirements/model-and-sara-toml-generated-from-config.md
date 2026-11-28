---
id: "REQ-76368939-a62b-47cb-b334-8bd7d7ee8389"
type: requirement
name: "model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる"
description: "model.yaml と sara.toml は設定ファイルから生成してコミットし、生成し直した結果との差分が無いことを CI で確かめる。"
specification: |
  mitodoke SHALL generate the model.yaml and the sara.toml of an adopting product from its
  configuration file. The generated files SHALL be committed to the repository, and CI SHALL
  verify that the committed files do not differ from the files regenerated from the
  configuration file.
specification_ja: |
  mitodoke は、適用先の製品の model.yaml と sara.toml を設定ファイルから生成しなければならない。
  生成物はリポジトリにコミットしなければならず、CI は、コミットした生成物と、設定ファイルから
  生成し直した結果との間に差分が無いことを確かめなければならない。
section: model-config
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:28:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:57:10+09:00"
---
# model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる

## 仕様

mitodoke は、適用先の製品の model.yaml と sara.toml を、設定ファイルから生成する。生成物は
コミットし、設定ファイルから生成し直した結果と差分が無いことを CI で確かめる。

## 出典

根拠の決定は次の ADR が持つ。

- [model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](../adr/model-generated-from-config.md)
- [設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする](../adr/config-file-mitodoke-yaml.md)

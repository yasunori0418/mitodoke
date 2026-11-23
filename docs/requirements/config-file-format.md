---
id: "REQ-26df91d3-8166-4192-9b78-7b4b82c306c8"
type: requirement
name: "設定ファイルは YAML の mitodoke.yaml とする"
description: "設定ファイルは YAML の mitodoke.yaml とし、独自の型・relation・フィールドは sara の model.yaml と同じ書き方で書けるようにする。"
specification: |
  The configuration file of mitodoke SHALL be a YAML file named `mitodoke.yaml`. Custom
  types, relations, and fields SHALL be writable in `mitodoke.yaml` in every notation that
  sara's model.yaml accepts, YAML tags included.
specification_ja: |
  mitodoke の設定ファイルは、`mitodoke.yaml` という名前の YAML のファイルでなければならない。
  独自の型・relation・フィールドは、sara の model.yaml が受け付ける書き方（YAML のタグを含む）の
  すべてで `mitodoke.yaml` に書けなければならない。
section: model-config
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:00:49+09:00"
---
# 設定ファイルは YAML の mitodoke.yaml とする

## 仕様

mitodoke の設定ファイルは、YAML で書く `mitodoke.yaml` とする。独自の型・relation・フィールドは、
sara の model.yaml が受け付ける書き方（YAML のタグを含む）のすべてで書ける。

- フィールドの型を表す `field_type: !enum` と `!list text` もこの書き方に含まれる

## 出典

根拠の決定は次の ADR が持つ。

- [設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする](../adr/config-file-mitodoke-yaml.md)

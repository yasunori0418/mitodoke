---
id: "REQ-3e39ec3b-6f45-4b66-a31a-0b9d489a0076"
type: requirement
name: "テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする"
description: "mitodoke はテスト資産の列挙を内蔵せず、設定に書いた列挙のコマンドの出力とコミットした一覧のファイルを合わせて 1 つの一覧にし、同じ資産識別子が 2 か所から出たら失敗にする。"
specification: |
  mitodoke SHALL NOT embed the enumeration of test assets. mitodoke SHALL read the inventory of test
  assets from the output of the enumeration commands and from the committed list files that the
  configuration declares, and the configuration SHALL be able to declare more than one command and
  more than one file together. Each line of a command output or a list file SHALL be one test in the
  tab-separated form `<asset identifier>\t<kind>\t<test name>`, where the test name may be empty and
  the asset identifier uses the same notation as the resource of a test case. mitodoke SHALL combine
  all sources into one inventory, and SHALL fail when the same asset identifier comes from more than
  one source. The configuration SHALL be able to declare the assets excluded from the inventory
  together with the reason for each exclusion. The procedure and test charter files of tests
  that a person performs SHALL be listed in the inventory through the committed list files, and
  their kind SHALL take one of two values, procedure or test charter.
specification_ja: |
  mitodoke は、テスト資産の列挙を内蔵してはならない。mitodoke は、設定に書いた列挙のコマンドの出力と、
  コミットした一覧のファイルから、テスト資産の一覧を読まなければならず、設定にはコマンドとファイルを
  それぞれ複数、併せて書けなければならない。コマンドの出力と一覧のファイルの各行は、1 つのテストを
  タブ区切りの `<資産識別子>\t<種別>\t<テスト名>` の形で表さなければならない。テスト名は空でもよく、
  資産識別子はテストケースの resource と同じ表記にする。mitodoke は、すべての出どころを合わせて 1 つの
  一覧にし、同じ資産識別子が 2 か所以上の出どころから出たときは失敗にしなければならない。設定には、
  一覧の対象から外す資産を、外す理由とともに書けなければならない。人が行うテストの手順書とテストチャーターの
  ファイルは、コミットした一覧のファイルからテスト資産の一覧に載せなければならず、その種別は手順書と
  テストチャーターの 2 つの値で表さなければならない。
section: commands
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:53:51+09:00"
---
# テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする

## 仕様

- `mitodoke` は、テスト資産の列挙を内蔵しない
- テスト資産の一覧は、設定に書いた列挙のコマンドの出力と、コミットした一覧のファイルから読む。設定にはコマンドとファイルをそれぞれ複数、併せて書ける
- コマンドの出力と一覧のファイルの各行は、1 つのテストをタブ区切りの `<資産識別子>\t<種別>\t<テスト名>` の形で表す。テスト名は空でもよい。資産識別子は、テストケースの `resource` と同じ表記にする
- すべての出どころを合わせて 1 つの一覧にする。同じ資産識別子が 2 か所以上の出どころから出たときは失敗にする
- 一覧の対象から外す資産は、外す理由とともに設定に書く
- 人が行うテストの手順書とテストチャーターのファイルは、コミットした一覧のファイルの経路でテスト資産の一覧に載せる。種別は手順書とテストチャーターの 2 つの値で表す

## 出典

根拠の決定は次の ADR が持つ。

- [テスト資産の列挙は内蔵せず、設定のコマンドかコミットしたファイルから読む](../adr/test-assets-listed-by-configured-sources.md)
- [テスト系 item を CASE・TC・RISK の 3 段で起こし、人が行うテストも CASE にする](../adr/test-items-in-three-tiers-with-human-tests.md)

---
id: "ADR-83727447-1044-4198-965f-8b1f42f31698"
type: adr
name: "text 出力の見出しと診断の文を英語に固定する"
description: "既定の text 出力の見出しと診断の文を英語に固定し、item の name と description は書かれた言語のまま出し、言語を切り替える仕組みは持たない。"
section: commands
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
references:
  - "ADR-45b47279-3cf0-4bda-9a57-00961cb8e1e6"
  - "ADR-2388688a-0bb5-42c3-8e71-76e6e733cf2c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:49:50+09:00"
---
# text 出力の見出しと診断の文を英語に固定する

- ステータス: stable
- 日付: 2026-11-23
- 関連: [利用者向けのスキルを公開用として英語で書く](user-skills-written-in-english.md), [写した契約テストを CLI の受け入れテストにする](contract-tests-as-cli-acceptance-tests.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

写した script は、text 出力の見出しと診断の文を日本語で書いている。mitodoke の CLI が既定の text 出力と
診断をどの言語で出すかは、決まっていなかった。

利用者向けのスキルは英語で書くと決めていて、`specification` も英語が必須である。
[写した契約テストを CLI の受け入れテストにする](contract-tests-as-cli-acceptance-tests.md) は、text 出力の
見出しと行の形式を受け入れテストで揃えないと決めている。

## 決定

既定の text 出力の見出しと、診断の文は、英語に固定する。item の `name` と `description` は、書かれた
言語のまま出す。言語を切り替える仕組みは持たない。

## 根拠

英語にすれば、利用者向けのスキルと `specification` と同じ言語になり、適用先の製品が日本語を読めることを
前提にしない。受け入れテストは text 出力の見出しを揃えないので、写した script の日本語の見出しを
引き継ぐ義務は無い。

item の `name` と `description` は利用者が書いたものなので、訳さずに出す。

## 棄却した代替案

### 日本語に固定する

写した script の見出しをそのまま引き継げるが、適用先の製品が日本語を読めることを前提にする。

### 設定で言語を選べるようにする

利用者が読める言語を選べるが、文言の一覧を言語ごとに持つことになり、最初のリリースの範囲を広げる。

---
id: "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
type: requirement
name: "サブコマンドは new・gap・fresh・index・matrix・model・verify・export・check とする"
description: "mitodoke の CLI は、起票・報告・生成・確認の記録・出力・検査を、機能ごとに分けた 9 つのサブコマンドで提供する。"
specification: |
  The mitodoke CLI SHALL provide the following subcommands, each for one function: new (create an
  item), gap (report missing connections), fresh (report items awaiting re-confirmation, stale
  generated records, and high risks without human verification), index (generate index.md),
  matrix (generate the table relating test assets to test cases, test conditions, and risks),
  model (generate model.yaml from the configuration), verify (record human verification), export
  (output the item list as JSON), and check (inspect). index and model SHALL provide a --check
  option that verifies the generated result does not differ from the committed file. The
  reporting and generating subcommands SHALL provide a --json option. check SHALL run the structural contracts, the missing-connection inspection, and
  the review-obligation inspection together, and SHALL decide for each finding whether to fail or
  to report according to the configured strength.
specification_ja: |
  mitodoke の CLI は、機能ごとに分けた次のサブコマンドを持たなければならない。new（item の起票）、
  gap（つながりの欠けの報告）、fresh（再確認待ち・generated の更新漏れ・人の確認が無い high の risk の
  報告）、index（index.md の生成）、matrix（テスト資産とテストケース・テスト条件・リスクの対応表の
  生成）、model（設定からの model.yaml の生成）、verify（人の確認の記録）、export（item の一覧の JSON
  の出力）、check（検査）。index と model は、生成した結果とコミットされたファイルに差分が無いことを
  確かめる --check を持たなければならない。報告と生成のサブコマンドは
  --json を持たなければならない。check は、構造の契約・つながりの欠け・見直しの義務の検査を
  まとめて実行し、指摘ごとに失敗にするか報告にするかを設定の強さで決めなければならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:04+09:00"
---
# サブコマンドは new・gap・fresh・index・matrix・model・verify・export・check とする

## 仕様

`mitodoke` の CLI は、機能ごとに分けた次の 9 つのサブコマンドを持つ。

| サブコマンド | 機能 |
|---|---|
| `mitodoke new` | item の起票 |
| `mitodoke gap` | つながりの欠けの報告 |
| `mitodoke fresh` | 再確認待ち・`generated` の更新漏れ・人の確認が無い high の risk の報告 |
| `mitodoke index` | index.md の生成 |
| `mitodoke matrix` | テスト資産とテストケース・テスト条件・リスクの対応表の生成 |
| `mitodoke model` | 設定からの model.yaml の生成 |
| `mitodoke verify` | 人の確認の記録 |
| `mitodoke export` | item の一覧の JSON の出力 |
| `mitodoke check` | 検査 |

- `index` と `model` は、生成した結果とコミットされたファイルに差分が無いことを確かめる `--check` を持つ
- 報告と生成のサブコマンドは `--json` を持つ。出力の形はこの item では定めない
- `check` は、構造の契約・つながりの欠け・見直しの義務の検査をまとめて実行し、指摘ごとに失敗にするか報告にするかを設定の強さで決める

## 出典

根拠の決定は次の ADR が持つ。

- [サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける](../adr/subcommands-split-by-function.md)

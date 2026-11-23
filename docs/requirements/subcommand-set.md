---
id: "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
type: requirement
name: "サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする"
description: "mitodoke の CLI は、初期化・起票・報告・生成・確認の記録・出力・検査を、機能ごとに分けた 10 個のサブコマンドで提供する。"
specification: |
  The mitodoke CLI SHALL provide the following subcommands, each for one function: init (generate
  the initial configuration file and directories), new (create an item), gap (report missing
  connections and list the test conditions that a person finally judges), fresh (report items
  awaiting re-confirmation, missing generated updates (items whose body changed in the difference
  from the base revision while `generated.at` did not change), items without a required human
  verification, and expired or overlong `stale_after` values), index (generate index.md), matrix
  (generate the table relating test assets to test cases, test conditions, and risks), model
  (generate model.yaml from the configuration), verify (record human verification; when no item is
  given, walk a branch chosen interactively), export (output the item list as JSON), and check
  (inspect). Every subcommand SHALL provide a --json option. index and model SHALL provide a
  --check option that verifies the generated result does not differ from the committed file. The
  --check option of index and model SHALL end with exit code 1 when there is a difference. check
  SHALL run the structural contracts, the missing-connection inspection, and the review-obligation
  inspection together, and SHALL decide for each finding whether to fail or to report according to
  the configured strength.
specification_ja: |
  mitodoke の CLI は、機能ごとに分けた次のサブコマンドを持たなければならない。init（初期の設定ファイルと
  ディレクトリの生成）、new（item の起票）、gap（つながりの欠けの報告と、人が最終的に判断するテスト条件の
  一覧）、fresh（再確認待ち・generated の更新漏れ（基準のリビジョンとの差分で本文が変わったのに
  `generated.at` が変わっていない item）・人の確認が要るのに無い item・stale_after の期限切れと間隔の超過の
  報告）、index（index.md の生成）、matrix（テスト資産とテストケース・テスト条件・リスクの対応表の生成）、
  model（設定からの model.yaml の生成）、verify（人の確認の記録。item を指定しないときは、対話で選んだ枝を
  たどる）、export（item の一覧の JSON の出力）、check（検査）。
  すべてのサブコマンドは --json を持たなければならない。
  index と model は、生成した結果とコミットされたファイルに差分が無いことを確かめる --check を持たなければ
  ならない。`index` と `model` の `--check` は、差分があれば exit code 1 で終わらなければならない。
  check は、構造の契約・つながりの欠け・見直しの義務の検査をまとめて実行し、指摘ごとに失敗にするか報告に
  するかを設定の強さで決めなければならない。
section: commands
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:47:00+09:00"
---
# サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする

## 仕様

`mitodoke` の CLI は、機能ごとに分けた次の 10 個のサブコマンドを持つ。

| サブコマンド | 機能 |
|---|---|
| `mitodoke init` | 初期の設定ファイルとディレクトリの生成 |
| `mitodoke new` | item の起票 |
| `mitodoke gap` | つながりの欠けの報告と、人が最終的に判断するテスト条件の一覧 |
| `mitodoke fresh` | 再確認待ち・`generated` の更新漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）・人の確認が要るのに無い item・`stale_after` の期限切れと間隔の超過の報告 |
| `mitodoke index` | index.md の生成 |
| `mitodoke matrix` | テスト資産とテストケース・テスト条件・リスクの対応表の生成 |
| `mitodoke model` | 設定からの model.yaml の生成 |
| `mitodoke verify` | 人の確認の記録。item を指定しないときは、対話で選んだ枝をたどる |
| `mitodoke export` | item の一覧の JSON の出力 |
| `mitodoke check` | 検査 |

- すべてのサブコマンドは `--json` を持つ。出力の形は [サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない](json-outturn-envelope.md) が定める
- `index` と `model` は、生成した結果とコミットされたファイルに差分が無いことを確かめる `--check` を持つ。差分があれば exit code 1 で終わる
- `check` は、構造の契約・つながりの欠け・見直しの義務の検査をまとめて実行し、指摘ごとに失敗にするか報告にするかを設定の強さで決める

## 出典

根拠の決定は次の ADR が持つ。

- [サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける](../adr/subcommands-split-with-init.md)

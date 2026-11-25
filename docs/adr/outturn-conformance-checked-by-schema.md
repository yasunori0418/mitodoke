---
id: "ADR-9d31f8b7-0e24-450c-80b9-bc48301c10c0"
type: adr
name: "outturn への適合は、--json の出力のサンプルを schema で確かめる"
description: "outturn への適合を受け入れテストの範囲に入れ、--json の出力のサンプルを outturn の flake の lib.mkSchemaCheck で確かめ、item の id の導出は確かめない。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "TP-2d0beccd-8660-4804-8637-4c4e83736efe"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:19:26+09:00"
---
# outturn への適合は、--json の出力のサンプルを schema で確かめる

- ステータス: stable
- 日付: 2026-11-24
- 関連: [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](json-output-conforms-to-outturn.md), [outturn の Rust の crate を outturn の側に作って使う](outturn-rust-crate-provided-by-outturn.md), GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

サブコマンドの `--json` は outturn のエンベロープにし、`standalone` まで適合させると決めてある。
エンベロープの型と item の `id` の導出は、outturn の側に作る Rust の crate が持つ。

outturn の適合の手引きには、flake の `lib.mkSchemaCheck` で出力のサンプルを schema で検証する手段がある。
outturn への適合を受け入れテストの範囲に入れるかは決まっていなかった。

## 決定

outturn への適合は受け入れテストの範囲に入れる。`--json` の出力のサンプルを、outturn の flake の
`lib.mkSchemaCheck` で確かめる。item の `id` の導出は確かめない。

## 根拠

`--json` を outturn のエンベロープにして適合させると決めたので、出力が schema に合うことを受け入れテストで
確かめる。

item の `id` の導出は outturn の crate のテストが持つので、mitodoke では確かめない。

## 棄却した代替案

### 子の epic F に任せる

outturn への適合を受け入れテストの範囲に入れず、子の epic F（結果の受け渡し）が自分で決める案。子の epic に
任せると、エンベロープの形が schema に合うかを確かめる場所が、テスト計画の上で決まらないまま実装に入る。

---
id: "ADR-2ef9fd58-2f13-4af7-9175-f17697f8cb2f"
type: adr
name: "generated.by は自由な文字列にする"
description: "generated.by の値は書式を限らない自由な文字列とし、空の値と二重引用符・バックスラッシュ・改行を含む値だけを拒む。"
section: commands
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q40）で確定"
justifies:
  - "REQ-a69187a5-ad91-4cee-bf29-efa34e79f812"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:37+09:00"
---
# generated.by は自由な文字列にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q40）で確定

## 背景

[generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする](generated-by-from-env-or-flag.md)
で `generated.by` の取り方を決めたが、値の書式は決めていなかった。

OKF v0.2 の actor には、`human:` や `process:` のような接頭辞の書き方がある。一方、`mitodoke` は
`generated.by` の値を判定に使わない。人の確認の判定に使うのは、`verified` の `human:` だけである。

## 決定

`generated.by` は自由な文字列にする。拒むのは、空の値と、`"`・`\`・改行を含む値だけにする（今の `sara-new` と同じ）。
エージェントの書き方（`claude-code/<モデル ID>` など）は README の例にとどめる。`mitodoke` は `generated.by` の値を判定に使わない。

受け付ける値と拒む値は [generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む](../requirements/generated-by-format.md) が定める。

## 根拠

- `mitodoke` は `generated.by` の値を判定に使わないので、形を限っても判定は何も変わらない
- エージェントの名前の付け方は、使うツールごとに違うので、README の例で示せば足りる

## 棄却した代替案

### `<種類>:<名前>` の形に限る

`human:<id>` や `agent:claude-code/<モデル ID>` のように、`<種類>:<名前>` の形に限る案。形を限っても判定は
変わらないうえ、このリポジトリへ写した ADR を含め、今ある値を書き換えることになるので採らなかった。

---
id: "ADR-715b563f-eedd-48d0-b456-0b5d6af65647"
type: adr
name: "契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える"
description: "契約の違反と報告は E_MITODOKE_<契約名> と W_MITODOKE_<契約名> のツール別のコードで統一し、強さの設定で接頭辞だけを切り替え、入力や環境の誤りには outturn の共通コードを使う。"
section: json-output
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q50）で確定"
justifies:
  - "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
references:
  - "ADR-7f1ac4f7-75b3-4837-9825-025a23f1673b"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:02:17+09:00"
---
# 契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える

- ステータス: stable
- 日付: 2026-11-17
- 関連: [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする](default-strength-fail-structure-report-gaps.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q50）で確定

## 背景

mitodoke の `--json` は outturn のエンベロープにすると決めた。outturn では、item の error と警告に
コードを付ける。接頭辞は error が `E_`、警告が `W_` である。

outturn §6 は、コードを 2 層に分けている。ほかのツールでも同じ意味で出しうるものは共通コード
（`E_<名前>`）、ツールの概念を知らないと意味が取れないものはツール別のコード
（`E_<ツール>_<名前>`）である。共通コードの初期の登録には `E_INPUT`・`E_IO`・`E_PRECONDITION`
などがある。§7 は check サブコマンドについて「不成立は `failed` + `E_PRECONDITION`」と書くが、
MUST の語は付いておらず、手本は適用の前に前提条件を確かめる check である。

mitodoke の検査の強さは設定で変えられるので、同じ指摘が失敗にも報告にもなる。単体の報告の
サブコマンドと `check` でも分かれる。そのため、同じ指摘に `E_` と `W_` の 2 つのコードが要る。
コードの付け方を決める必要があった。

## 決定

契約の違反と報告は、ツール別のコードで統一する。失敗は `E_MITODOKE_<契約名>`、報告は
`W_MITODOKE_<契約名>` にする。同じ指摘は契約名を共通にし、強さの設定で接頭辞だけを切り替える。
入力や環境の誤り（exit code 2）には、outturn の共通コード（`E_INPUT`・`E_IO` など）を使う。
`check` の違反にも `E_PRECONDITION` は使わない。

## 根拠

「要求を脅かす risk が無い」のような違反は、mitodoke の概念を知らないと意味が取れないので、§6 の
判断基準ではツール別のコードになる。§7 の `E_PRECONDITION` が想定しているのは、適用の前に前提を
確かめる check で、文書の契約の検査とは役割が違う。

契約名を `E_` と `W_` で共通にしておけば、消費側は強さの設定に関わらず、同じ指摘を同じ名前で
拾える。

## 棄却した代替案

### check の違反は E_PRECONDITION にする

`check` の違反は §7 のとおり `E_PRECONDITION` にし、契約の名前は item の `kind` で表す案。`gap`・
`fresh` の該当と報告は、ツール別のコードにする。`check` と `gap` で同じ違反に違うコードが付き、
消費側が 2 通りの拾い方を持つことになる。

---
id: "ADR-941d3900-029c-4806-bac8-79ae5e9df389"
type: adr
name: "報告の指摘は success の item の警告で表し、働く強さは exit code で決める"
description: "指摘に働く強さをその実行の exit code を 0 でなくするかで決め、失敗は failed の item と E_MITODOKE_ のコード、報告は success の item と W_MITODOKE_ の警告で表し、gap の情報の節と到達率は result.info に置く。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
  - "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
references:
  - "ADR-6f2020c5-dc77-44c6-8471-1bd2f72f1f48"
  - "ADR-715b563f-eedd-48d0-b456-0b5d6af65647"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:24:39+09:00"
---
# 報告の指摘は success の item の警告で表し、働く強さは exit code で決める

- ステータス: stable
- 日付: 2026-11-23
- 関連: [check・gap・fresh の item を契約 × 文書の単位にする](result-items-per-contract-and-document.md), [契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える](tool-specific-error-and-warning-codes.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

`check`・`gap`・`fresh` の結果は、契約と文書の組を単位とする item で表し、成り立った組は item にしないと
決めていた。報告の強さの指摘だけを持つ組の表し方は、決めていなかった。コードは、その実行で指摘に働く
強さが失敗なら `E_MITODOKE_<契約名>`、報告なら `W_MITODOKE_<契約名>` にすると決めていたが、「その実行で
指摘に働く強さ」が何で決まるかは書いていなかった。

outturn では、トップレベルの `status` が `success` であることと exit code 0 が対応する。`failed` の item は
`error` を必ず持ち、`success` の item は `warnings` を持てる。警告は `status` の集約に影響しない。

## 決定

- 「その実行で指摘に働く強さ」は、その指摘がその実行の exit code を 0 でなくするかどうかで決まる。0 で
  なくするなら失敗、しないなら報告である
- 失敗の指摘は、`failed` の item と、`error` の `E_MITODOKE_<契約名>` で表す
- 報告の指摘は、`success` の item と、`warnings` の `W_MITODOKE_<契約名>` で表す。報告の指摘だけを持つ
  組も item にする。成り立った組は item にしない
- 単体の `gap` と `fresh` では、該当した組はすべて失敗で、該当した組があれば exit 1 で終わる
- `check` は強さの設定に従い、報告の指摘だけなら exit 0 で、`status` は `success` になる
- `gap` の情報の節（`risk_exempt` を持つ要件の一覧、`human_judgement` を持つテスト条件の一覧）と
  到達率は、item にせず `result.info` に置く

## 根拠

強さを exit code で定義すれば、同じ契約の指摘が、単体の `gap` や `fresh` では失敗、`check` では設定に
よって報告になることを、1 つの規則で説明できる。

報告の指摘も item にすれば、`kind` と `key` を持てるので、どの文書のどの契約の指摘かを、失敗の指摘と
同じ形で読める。`success` の item の警告にすれば、outturn の `status` の集約に影響せず、exit code 0 と
食い違わない。

`gap` の情報の節と到達率は、文書が契約に反したことを表す指摘ではないので、item にしない。

## 棄却した代替案

### 報告の指摘を item にせず、`results[]` の要素の `warnings` に並べる

item は失敗だけになるが、警告は `kind` と `key` を持てないので、どの文書の指摘かを `info` で運ぶことに
なり、失敗と報告で読み方が分かれる。

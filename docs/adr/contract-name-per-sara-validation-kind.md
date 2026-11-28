---
id: "ADR-c5b0d324-1077-4401-a881-482b82222147"
type: adr
name: "sara の検証の種類ごとに契約名を割り当て、kind とコードを契約名から導く"
description: "sara の検証を指摘の種類ごとに mitodoke の契約名へ割り当て、読み飛ばしにも契約名を割り当て、kind は契約名の小文字のスネークケース、コードはその大文字に接頭辞を付けたものにする。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
references:
  - "ADR-715b563f-eedd-48d0-b456-0b5d6af65647"
  - "ADR-8d944bb2-632e-471c-9cf0-f1b7e8e1f679"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:59:57+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:24:03+09:00"
---
# sara の検証の種類ごとに契約名を割り当て、kind とコードを契約名から導く

- ステータス: stable
- 日付: 2026-11-23
- 関連: [契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える](tool-specific-error-and-warning-codes.md), [読み飛ばしは check を失敗させ、グラフを読むほかのサブコマンドを止める](scan-skips-fail-check-and-block-graph-commands.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

sara-core の検証は、指摘ごとに種類（参照先の無い relation、接続漏れなど 8 つ）を返す。`check` は
`sara check` を構造の契約の 1 つとして持つ。item の `kind` は契約の名前で、コードは
`E_MITODOKE_<契約名>` か `W_MITODOKE_<契約名>` にすると決めていたが、sara の検証をいくつの契約として
扱うかと、契約名から `kind` とコードをどう書くかは、決まっていなかった。

## 決定

- sara の検証は 1 つの契約にまとめず、指摘の種類ごとに mitodoke の契約名を 1 つずつ割り当てる
- 割り当ての表は、sara-core を呼ぶモジュールが持つ。表に無い種類が返ったら、内部の誤りとして exit 2 で
  終える
- 読み飛ばしにも、契約名を 1 つ割り当てる
- item の `kind` は、契約名を小文字のスネークケースで書く。コードは、同じ契約名を大文字にして接頭辞を
  付ける
- 既定の強さは、どれも失敗である

契約名の一覧は、それぞれの契約を実装する子の epic が決め、この規則に従う。

## 根拠

種類ごとに契約名を割り当てれば、結果を読む側が、参照先の無い relation と接続漏れを、文言を読まずに
`kind` とコードで見分けられる。

表を sara-core を呼ぶモジュールに置けば、sara を上げて種類が増えたときに、割り当ての無い種類を黙って
通さず、内部の誤りとして気づける。

`kind` とコードを同じ契約名から機械的に導けば、片方からもう片方を読み取れる。sara の検証はどれも
`sara check` の一部なので、既定の強さは構造の契約と同じ失敗にする。

## 棄却した代替案

### sara の検証を 1 つの契約にまとめる

sara を上げて種類が増減しても契約名は変わらないが、種類は `info` か文言でしか伝わらない。

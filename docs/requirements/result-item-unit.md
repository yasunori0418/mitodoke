---
id: "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
type: requirement
name: "check・gap・fresh の item は契約と文書の組を単位とする"
description: "check・gap・fresh の結果エンベロープは、1 つの文書が 1 つの契約に反したことを item 1 つで表し、成り立った組は item にしない。"
specification: |
  In the result envelopes of check, gap and fresh, mitodoke SHALL represent each case in which
  one document violates one contract (for gap and fresh, each case in which one document falls
  under one section) as one item. The kind of the item SHALL be the name of the contract and its
  key SHALL be the ID of the document. The `key` and the `label` of an item that has no document
  ID, such as a skipped file, SHALL be the path relative to the directory that contains the
  configuration file, and the `label` of an item that represents a document SHALL be the `name`
  of the document. The items SHALL be placed in the single element of `results[]` whose
  `subject.name` is `documents`, and check, gap and fresh SHALL set `dryRun` to true and SHALL NOT
  emit `changes[]`. The strength applied to a finding in a run SHALL be
  failure when the finding makes the exit code of the run non-zero, and report otherwise.
  mitodoke SHALL represent a pair that has a finding at failure strength as an item whose status
  is failed, and a pair that has only findings at report strength as an item whose status is
  success and which carries the findings as warnings. mitodoke SHALL NOT emit an item for a pair
  of a contract and a document that holds. In gap and fresh run alone, every pair that falls
  under a section SHALL be a failure, and the run SHALL end with exit code 1 when such a pair
  exists. check SHALL follow
  the strength setting, and when it has only findings at report strength it SHALL end with exit
  code 0 and its status SHALL be success. The information sections of gap (the requirements with
  `risk_exempt` and the test conditions with `human_judgement`) and the reach ratios SHALL NOT be
  items and SHALL be placed in `result.info`.
specification_ja: |
  check・gap・fresh の結果エンベロープでは、mitodoke は、1 つの文書が 1 つの契約に反したこと
  （gap と fresh では、1 つの文書が 1 つの節に該当したこと）を、item 1 つで表さなければならない。
  item の kind は契約の名前で、key は文書の ID でなければならない。読み飛ばされたファイルのような、
  文書の ID を持たない item の `key` と `label` は、設定ファイルのあるディレクトリからの相対パスで
  なければならず、文書を表す item の `label` は文書の `name` でなければならない。item は、
  `subject.name` が `documents` の、`results[]` のただ 1 つの要素に置かなければならず、check・gap・
  fresh は、`dryRun` を true にしなければならず、`changes[]` を出してはならない。その実行で指摘に働く強さは、
  その指摘がその実行の exit code を 0 でなくするなら失敗、しないなら報告でなければならない。
  mitodoke は、失敗の強さの指摘を持つ組を status が failed の item で表さなければならず、報告の強さの
  指摘だけを持つ組を、status が success で指摘を warnings に持つ item で表さなければならない。
  mitodoke は、成り立った契約と文書の組を item にしてはならない。単体の gap と fresh では、節に該当
  した組はすべて失敗でなければならず、該当した組があれば exit code 1 で終わらなければならない。check は強さの設定に
  従わなければならず、報告の強さの指摘だけなら exit code 0 で終わり、status は success でなければ
  ならない。gap の情報の節（`risk_exempt` を持つ要件の一覧と、`human_judgement` を持つテスト条件の
  一覧）と到達率は、item にしてはならず、`result.info` に置かなければならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:15:54+09:00"
---
# check・gap・fresh の item は契約と文書の組を単位とする

## 仕様

`check`・`gap`・`fresh` は、検査の結果を、契約と文書の組を単位とする item で表す。1 つの文書が
1 つの契約に反したこと（`gap` と `fresh` では、1 つの文書が 1 つの節に該当したこと）が、item
1 つになる。item の `kind` は契約の名前、`key` は文書の ID である。

- 読み飛ばされたファイルのような、文書の ID を持たない item の `key` と `label` は、設定ファイルのある
  ディレクトリからの相対パスにする
- 文書を表す item の `label` は、文書の `name` にする
- item は、`subject.name` が `documents` の、`results[]` のただ 1 つの要素に置く。`check`・`gap`・
  `fresh` は読むだけのサブコマンドなので、`dryRun` を `true` にし、`changes[]` を出さない

その実行で指摘に働く強さは、その指摘がその実行の exit code を 0 でなくするかどうかで決まる。0 でなく
するなら失敗、しないなら報告である。

- 失敗の指摘を持つ組は、`status` が `failed` の item で表す
- 報告の指摘だけを持つ組も item にし、`status` が `success` で、指摘を `warnings` に持つ item で表す
- 成り立った組は item にしない
- 単体の `gap` と `fresh` では、節に該当した組はすべて失敗で、該当した組があれば exit code 1 で終わる
- `check` は強さの設定に従う。報告の指摘だけなら exit code 0 で終わり、`status` は `success` になる
- `gap` の情報の節（`risk_exempt` を持つ要件の一覧と、`human_judgement` を持つテスト条件の一覧）と
  到達率は、item にせず、`result.info` に置く

指摘に付けるコードは
[契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す](error-and-warning-codes.md) が定める。

## 出典

根拠の決定は次の ADR が持つ。

- [check・gap・fresh の item を契約 × 文書の単位にする](../adr/result-items-per-contract-and-document.md)
- [報告の指摘は success の item の警告で表し、働く強さは exit code で決める](../adr/report-findings-as-success-items-with-warnings.md)
- [changes・dryRun・label はファイルを書くかで分け、ID の無い item はパスで表す](../adr/envelope-changes-dry-run-label-and-path-keys.md)

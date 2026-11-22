---
id: "REQ-05cc6e6a-6440-429f-8447-16bd7b192d9c"
type: requirement
name: "gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする"
description: "mitodoke gap は有効な requirement を持たない有効な use_case、親の use_case がすべて deprecated の有効な requirement、有効な risk を持たず対象外にもしていない品質特性をつながりの欠けとして報告し、human_judgement を持つ有効な test_condition を情報として一覧にする。"
specification: "As missing connections, mitodoke gap SHALL report (1) a `use_case` whose `status` is not `deprecated` and from which no `requirement` whose `status` is not `deprecated` derives, (2) a `requirement` whose `status` is not `deprecated` and all of whose parent `use_case` items are `deprecated`, and (3) a quality characteristic that no `risk` whose `status` is not `deprecated` carries and that the configuration does not declare out of scope. A `requirement` that has at least one parent `use_case` whose `status` is not `deprecated` SHALL NOT be reported under (2). mitodoke gap SHALL list, as information, every `test_condition` whose `status` is not `deprecated` and that carries `human_judgement`, and that list SHALL NOT be counted as a missing connection."
specification_ja: "mitodoke gap はつながりの欠けとして次を報告しなければならない。(1) `status` が `deprecated` でなく、`status` が `deprecated` でない `requirement` に `derives_from` されていない `use_case`。(2) `status` が `deprecated` でなく、親の `use_case` がすべて `deprecated` の `requirement`。(3) `status` が `deprecated` でない `risk` のどれにも持たれず、設定で対象外と宣言されていない品質特性。`status` が `deprecated` でない親の `use_case` を 1 本でも持つ `requirement` は、(2) として報告してはならない。mitodoke gap は `status` が `deprecated` でなく `human_judgement` を持つ `test_condition` を情報として一覧にしなければならず、その一覧をつながりの欠けに数えてはならない。"
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:58:51+09:00"
---
# gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする

## 仕様

- 有効な `requirement` を 1 本も持たない有効な `use_case` を報告する。`deprecated` の `requirement` しか持たない `use_case` も報告する
- 親の `use_case` がすべて `deprecated` の有効な `requirement` を報告する。有効な親が 1 本でも残っていれば報告しない
- 有効な `risk` を 1 本も持たない品質特性を報告する。設定で理由とともに対象外にした特性は報告しない
- `human_judgement` を持つ有効な `test_condition` を、人が最終的に判断するものの一覧として出す。一覧は情報で、[つながりの欠け](../ubiquitous-language/missing-connection.md)には数えない
- 「有効な」は、`status` が `deprecated` でないことを指し、`draft` を含む

## 出典

根拠の決定は次の ADR が持つ。

- [棄却した提案の要求・要件・設計は提案の形の題で deprecated にして残す](../adr/rejected-proposals-deprecated-including-use-cases.md)
- [risk に ISO/IEC 25010:2023 の品質特性を 1 つ必須で持たせる](../adr/risk-quality-characteristic.md)
- [test_condition に、人が最終的に判断する理由の human_judgement を持たせる](../adr/test-condition-human-judgement.md)

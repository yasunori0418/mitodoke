---
id: "ADR-5f60a34f-f0b0-4fce-8c56-9b35502d81f3"
type: adr
name: "棄却した提案の要求・要件・設計は提案の形の題で deprecated にして残す"
description: "棄却した提案と作らないと決めた機能を記録する use_case・requirement・design は、提案の形の題と本文に棄却の記述を添え、status を deprecated にして残す。"
section: authoring
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定。棄却した提案の要件と設計は提案の形の題で deprecated にして残す ADR を書き直した"
justifies:
  - "QA-67715bb3-1162-4ccf-8441-2f44257a57da"
supersedes:
  - "ADR-fb902413-ff78-45b2-9ddd-3fc25f493208"
references:
  - "ADR-05ab6fb0-899b-46e7-a853-82ed1b6857ff"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
---
# 棄却した提案の要求・要件・設計は提案の形の題で deprecated にして残す

- ステータス: stable
- 日付: 2026-11-22
- 関連: [棄却した提案の要件と設計は提案の形の題で deprecated にして残す](rejected-proposals-deprecated.md), [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](upper-layers-validated-by-review-questions.md), GitHub Issue #80, `docs/model.md`
- 起点: issue #80 の grilling（2026-11-22）で確定。棄却した提案の要件と設計は提案の形の題で deprecated にして残す ADR を書き直した

## 背景

これまで、棄却した提案を `deprecated` で残す決定は要件と設計だけを対象にしていた。要求の `use_case` には、
作らないと決めた機能を記録する決まった形が無かった。

`use_case` は `solution` の下で利用者がどう使うかを書き、[確認の問い](../ubiquitous-language/review-question.md)に
人が答える[妥当性確認](../ubiquitous-language/validation.md)でカバーする。確認の問いの 1 つは、作らないと
決めたものは何か、その判断は今も妥当か、を問う。答えるには、作らないと決めたものがグラフから読めなければならない。

## 決定

- `use_case`・`requirement`・`design` で棄却した提案は、提案の形の題で `status` を `deprecated` にして残す。
  本文の先頭に棄却した旨を書き、`specification` を持つ型では `specification` も提案の形で書く
- 作らないと決めた機能はその `use_case` を `status: deprecated` にし、作らない理由を散文で補う
- 肯定の規範が中心で否定が付随するだけの item は対象にしない。題に否定が入っているなら、決定の形に
  改めるだけにする
- `deprecated` の `use_case` から導かれた有効な `requirement`（`status` が `deprecated` でないもの。`draft` を含む）は、未カバーとして報告する。親の
  `use_case` がすべて `deprecated` のものだけを出し、有効な親が 1 本でも残っていれば出さない
- 有効な `requirement` を 1 本も持たない有効な `use_case` を報告する。`deprecated` の `requirement`
  しか持たない有効な `use_case` も報告する

## 根拠

棄却 ADR と同じ読み方になる。`name` が提案を表し、`status` が棄却を表す。`use_case` に広げれば、
作らないと決めた範囲が要求の層で読め、確認の問いに答えるときの材料になる。

作らないと決めた範囲を `deprecated` で表すので、有効な `use_case` は満たすべき要件を持つはずである。
要件を持たない有効な `use_case` は、要件の書き漏れか、`deprecated` にし忘れた要求のどちらかになる。
`deprecated` の `use_case` から導かれたまま有効な `requirement` は、作らないと決めた要求の下に要件が
残っていることを表す。

## 棄却した代替案

### 否定の題のまま `stable` で残す

「提供しない」という否定が、有効な要求や要件と同じ扱いで並ぶ。棄却 ADR とも書き方が一致しない。

### `specification` は `SHALL NOT` のまま残す

提案の形の題と本文が逆向きになる。

### 作らないと決めた機能を solution の散文だけに書く

要求の層で読めず、どの `use_case` の範囲で作らないと決めたかを辿れない。

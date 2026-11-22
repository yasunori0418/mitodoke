---
id: "QA-96fe5f3e-37bb-4094-bcf8-b9eeddbcf45b"
type: quality
name: "use_case の確認の問い"
description: "use_case に人の確認を記録する前に人が答える、3 つの確認の問い。"
specification: "Before recording a human verification on a `use_case` item, a person SHALL answer each of the following review questions. (1) Is this requirement aligned with the direction of the `solution`? (2) Does meeting this requirement bring value that existing products do not provide? (3) Within the scope of this requirement, what has been decided not to build, and is that decision still valid? The answers SHALL NOT be kept in the graph, and only the fact that they were answered SHALL be recorded as a `verified` entry."
specification_ja: "`use_case` に人の確認を記録する人は、記録の前に次の確認の問いのそれぞれに答えなければならない。(1) この要求は、`solution` の方向性とずれていないか。(2) この要求を満たすことに、既存の製品では得られない価値があるか。(3) この要求の範囲で、作らないと決めたものは何か。その判断は今も妥当か。答えはグラフに置いてはならず、答えた事実だけを `verified` の要素として記録しなければならない。"
review_question_for: use_case
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:39:58+09:00"
---
# use_case の確認の問い

## 仕様

この item は、`use_case` の[妥当性確認](../ubiquitous-language/validation.md)で人が答える
[確認の問い](../ubiquitous-language/review-question.md)を持つ。`review_question_for` が `use_case` の
`quality` の item は、どれも `use_case` の確認の問いとして読む。適用先の製品は
`review_question_for` に `use_case` を持つ自分の `quality` の item で問いを足す。

### 確認の問い

1. この要求は、`solution` の方向性とずれていないか
2. この要求を満たすことに、既存の製品では得られない価値があるか
3. この要求の範囲で、作らないと決めたものは何か。その判断は今も妥当か

答えの中身は mitodoke が判断しない。問いに答えて確かめた事実は、人の確認として `verified` に記録する。

## 出典

根拠の決定は次の ADR が持つ。

- [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](../adr/upper-layers-validated-by-review-questions.md)

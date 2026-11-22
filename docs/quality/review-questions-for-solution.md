---
id: "QA-3996a09e-f103-4b91-94b3-82764f97aa0c"
type: quality
name: "solution の確認の問い"
description: "solution に人の確認を記録する前に人が答える、3 つの確認の問い。"
specification: "Before recording a human verification on a `solution` item, a person SHALL answer each of the following review questions. (1) Is this direction aligned with what the product should be? (2) Does the unique value over existing products still hold? (3) What has been decided not to build, and is that decision still valid? The answers SHALL NOT be kept in the graph, and only the fact that they were answered SHALL be recorded as a `verified` entry."
specification_ja: "`solution` に人の確認を記録する人は、記録の前に次の確認の問いのそれぞれに答えなければならない。(1) この方向性は、製品のあるべき形とずれていないか。(2) 既存の製品に対する独自の価値は、今も成り立っているか。(3) 作らないと決めたものは何か。その判断は今も妥当か。答えはグラフに置いてはならず、答えた事実だけを `verified` の要素として記録しなければならない。"
review_question_for: solution
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:39:58+09:00"
---
# solution の確認の問い

## 仕様

この item は、`solution` の[妥当性確認](../ubiquitous-language/validation.md)で人が答える
[確認の問い](../ubiquitous-language/review-question.md)を持つ。`review_question_for` が `solution` の
`quality` の item は、どれも `solution` の確認の問いとして読む。適用先の製品は
`review_question_for` に `solution` を持つ自分の `quality` の item で問いを足す。

### 確認の問い

1. この方向性は、製品のあるべき形とずれていないか
2. 既存の製品に対する独自の価値は、今も成り立っているか
3. 作らないと決めたものは何か。その判断は今も妥当か

答えの中身は mitodoke が判断しない。問いに答えて確かめた事実は、人の確認として `verified` に記録する。

## 出典

根拠の決定は次の ADR が持つ。

- [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](../adr/upper-layers-validated-by-review-questions.md)

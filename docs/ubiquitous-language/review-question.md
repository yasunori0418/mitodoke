---
id: "UBQ-cc09ba6c-486f-4d42-85ce-3613251d54d6"
type: ubiquitous_term
name: "review question"
description: "`solution` と `use_case` に人の確認を記録する前に人が答える、型ごとに決めた問い。"
name_ja: "確認の問い"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:36:33+09:00"
---
# review question

## Definition

A question, fixed per type, that a person answers before recording a
[human verification](human-verification.md) on a `solution` or `use_case` item. The
questions for each type ship with the product as one `quality` item, and its
`review_question_for` names the type the questions apply to. A product that adopts
mitodoke adds questions with its own `quality` items. mitodoke holds the questions and the
record that they were answered, and does not judge the answers. The answers are not kept
in the graph.

## 定義

`solution` と `use_case` に[人の確認](human-verification.md)を記録する前に人が答える、型ごとに
決めた問い。型ごとに 1 本の `quality` の item として製品に同梱し、`review_question_for` で問いを
当てる型を示す。適用先の製品は自分の `quality` の item で問いを足す。mitodoke が持つのは問いと、
答えたという記録までで、答えの中身は判断しない。答えはグラフに置かない。

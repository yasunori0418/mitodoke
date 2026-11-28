---
id: "UBQ-0b4289c9-4f39-4ee5-860c-755a937ad473"
type: ubiquitous_term
name: "validation"
description: "`solution` と `use_case` が利用者の本当のニーズを表しているかを、人が確かめること。"
name_ja: "妥当性確認"
section: freshness
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:36:33+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:21:12+09:00"
---
# validation

## Definition

A person's check that the upper-layer artifacts, the `solution` and the `use_case` items,
express what users actually need. It is distinguished from verification, which checks
that an artifact was built as its requirements specify. The person answers the
[review questions](review-question.md) and then records the fact of checking in `verified`
as a [human verification](human-verification.md). Validation names the act of checking and
its record is a human verification; validation has no record of its own. The answers are
not kept in the graph. The Japanese name follows the JSTQB Foundation Level syllabus
2023V4.0.J02.

## 定義

上位の成果物である `solution` と `use_case` が利用者の本当のニーズを表しているかを、人が
確かめること。成果物が要件どおりに作られたかを確かめる検証（verification）とは区別する。人は
[確認の問い](review-question.md)に答えてから、確かめた事実を `verified` に
[人の確認](human-verification.md)として記録する。妥当性確認は確かめる行為の名前で、その記録は
人の確認であり、妥当性確認に固有の記録は無い。答えの中身はグラフに置かない。日本語名は
JSTQB FL シラバス 2023V4.0.J02 に合わせた。

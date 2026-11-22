---
id: "REQ-73949e27-20a9-4df4-9265-a7d7048d22fe"
type: requirement
name: "verify は、solution と use_case の確認を記録する前に確認の問いを表示する"
description: "mitodoke verify は solution と use_case に人の確認を記録する前に、その型に当てる確認の問いを表示し、答えは記録しない。"
specification: "When mitodoke verify records a human verification on a `solution` or `use_case` item, it SHALL display, before recording, the review questions of every `quality` item whose `review_question_for` names the type of that item. mitodoke verify SHALL NOT record the answers to the review questions."
specification_ja: "mitodoke verify は `solution` か `use_case` の item に人の確認を記録するとき、記録する前に、`review_question_for` がその item の型を指す `quality` の item の確認の問いをすべて表示しなければならない。mitodoke verify は確認の問いへの答えを記録してはならない。"
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:58:51+09:00"
---
# verify は、solution と use_case の確認を記録する前に確認の問いを表示する

## 仕様

- `solution` か `use_case` の item に人の確認を記録するとき、記録する前に、その型に当てる[確認の問い](../ubiquitous-language/review-question.md)を表示する。問いは、`review_question_for` がその型を指す `quality` の item から読む。適用先の製品が足した問いも表示する
- 答えはグラフに置かず、記録するのは人の確認だけにする

## 出典

根拠の決定は次の ADR が持つ。

- [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](../adr/upper-layers-validated-by-review-questions.md)

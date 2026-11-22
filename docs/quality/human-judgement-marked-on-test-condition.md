---
id: "QA-05493ea1-6af7-43b6-97bc-051bbb6fd8d1"
type: quality
name: "人が最終的に判断する test_condition は、human_judgement に理由を書いて一覧にする"
description: "test_condition は機械で確かめるのを既定にし、人が最終的に判断するものだけが human_judgement に理由の 1 文を持ち、それを情報として一覧にする。"
specification: "A `test_condition` SHALL be verified by machine by default. A test condition whose pass or fail a person finally judges SHALL carry `human_judgement` stating the reason in one sentence, and a `human_judgement` without a reason SHALL NOT be written. Test conditions whose `status` is not `deprecated` and that carry `human_judgement` SHALL be listed mechanically as information, and the list SHALL NOT be counted as uncovered."
specification_ja: "`test_condition` は機械で確かめるのを既定にしなければならない。人が最終的に合否を判断する `test_condition` は、その理由を 1 文で書いた `human_judgement` を持たなければならず、理由の無い `human_judgement` を書いてはならない。`status` が `deprecated` でなく `human_judgement` を持つ `test_condition` は情報として機械的に一覧にされなければならず、その一覧を未カバーに数えてはならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:52:17+09:00"
---
# 人が最終的に判断する test_condition は、human_judgement に理由を書いて一覧にする

## 仕様

AI エージェントによる開発の速度を保つため、`test_condition` は機械で確かめるのを既定にする。人が最終的に
判断するものだけに `human_judgement` を書き、理由の 1 文を値にする。書き方は `requirement` の
`risk_exempt` と同じにする。

`human_judgement` を持つ有効な `test_condition` は、人が最終的に判断するものの一覧として出す。一覧は人の
判断が要る範囲を示す情報で、未カバーではない。人が行うテストの `test_case` は、手順書かテストチャーターの
ファイルを `resource` で指す。

## 出典

根拠の決定は次の ADR が持つ。

- [test_condition に、人が最終的に判断する理由の human_judgement を持たせる](../adr/test-condition-human-judgement.md)

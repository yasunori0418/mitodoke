---
id: "UBQ-c454994c-fbe2-4268-80ea-cf602d5f2109"
type: ubiquitous_term
name: "verified"
description: "item の内容を誰がいつ確認したかを、要素ごとに記録する frontmatter のプロパティ。"
section: freshness
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:56:24+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:21:27+09:00"
---
# verified

## Definition

The frontmatter property that lists the checks of an item's content, each element
recording who checked it (`by`) and when (`at`). The checker may be a person or a machine.
Only an element whose `by` is `human:<id>` counts as a human verification, and it records the
act of checking, not an automatic judgment that the item is correct. Any element at or
after `generated.at` advances the item's reference time, whoever the checker is.

## 定義

item の内容の確認を、誰が（`by`）いつ（`at`）確認したかの要素として並べる frontmatter の
プロパティ。確認したのは人間でも機械でもよい。人の確認として数えるのは `by` が
`human:<id>` の要素だけで、それは item が正しいという自動判定ではなく、確認した行為を表す。
`generated.at` 以降の要素は、確認したのが誰であっても item の基準時刻を進める。

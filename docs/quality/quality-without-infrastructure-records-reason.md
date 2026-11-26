---
id: "QA-cddaeec3-b9f7-458a-815a-6a14213557ed"
type: quality
name: "infrastructure に支えられない quality は、infrastructure_exempt に理由を書いて一覧にする"
description: "infrastructure に satisfies されない quality だけが infrastructure_exempt に理由の 1 文を持ち、まだ作っていない仕組みは draft の item で表し、理由を持つ quality を情報として一覧にする。"
specification: "A `quality` that no `infrastructure` satisfies SHALL carry `infrastructure_exempt` stating the reason in one sentence. A `quality` that a mechanism not yet built is to support SHALL NOT carry `infrastructure_exempt`; that mechanism SHALL be raised as an item whose `status` is `draft`. Every `quality` whose `status` is not `deprecated` and that carries `infrastructure_exempt` SHALL be listed mechanically as information, and that list SHALL NOT be counted as uncovered."
specification_ja: "`infrastructure` に `satisfies` されない `quality` は、その理由を 1 文で書いた `infrastructure_exempt` を持たなければならない。まだ作っていない仕組みに支えられる `quality` に `infrastructure_exempt` を書いてはならず、その仕組みを `status` が `draft` の item として起こさなければならない。`status` が `deprecated` でなく `infrastructure_exempt` を持つ `quality` は情報として機械的に一覧にされなければならず、その一覧を未カバーに数えてはならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:10:24+09:00"
---
# infrastructure に支えられない quality は、infrastructure_exempt に理由を書いて一覧にする

## 仕様

仕組みに支えられない `quality` だけに `infrastructure_exempt` を書き、理由の 1 文を値にする。書き方は
`requirement` の `risk_exempt` と同じにする。

支える仕組みをまだ作っていない `quality` には `infrastructure_exempt` を書かない。その仕組みを `status` が
`draft` の item として起こし、`satisfies` を張る。

`infrastructure_exempt` を持つ有効な `quality` は、仕組みで支えない規範の一覧として出す。一覧は情報で、
未カバーではない。

## 出典

根拠の決定は次の ADR が持つ。

- [quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す](../adr/quality-infrastructure-exempt.md)

---
id: "QA-927c1c38-06b7-4980-baf1-d354a9470203"
type: quality
name: "sara は必要なときに上げ、組み込む版と配る版を同じタグに揃える"
description: "sara のタグを上げる時機と、上げるときに組み込む版と配る版を同じタグに揃えて確かめる手順を定める。"
specification: "The project SHALL upgrade sara only when a feature or fix that mitodoke needs is included in a newer sara tag. An upgrade SHALL move both the embedded sara-core in Cargo.lock and the sara input of the flake to the same tag in one pull request, and that pull request SHALL pass the acceptance tests and the mitodoke check of mitodoke's own documents. A fix that upstream sara does not have SHALL be proposed upstream from the fork, and sara SHALL be upgraded to the tag that includes it."
specification_ja: "sara は、mitodoke に要る機能や修正が新しいタグに入ったときにだけ上げなければならない。上げるときは、Cargo.lock の組み込む sara-core と flake の sara の input を 1 つの pull request で同じタグへ揃えなければならず、その pull request で受け入れテストと mitodoke 自身の文書に対する mitodoke check を成功させなければならない。upstream の sara に無い修正は fork から upstream へ提案し、取り込まれたタグで sara を上げなければならない。"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:46+09:00"
---
# sara は必要なときに上げ、組み込む版と配る版を同じタグに揃える

## 仕様

sara のタグは、mitodoke に要る機能や修正が新しいタグに入ったときにだけ上げる。新しいタグが出た
ことだけを理由には上げない。

上げるときは、組み込む sara-core（Cargo.lock）と配る sara の CLI（flake の input）を、1 つの
pull request で同じタグへ揃える。その pull request では、受け入れテストと、mitodoke 自身の文書に
対する `mitodoke check` を成功させる。

mitodoke に要る修正が upstream の sara に無いときは、fork から upstream へ pull request を出し、
取り込まれたタグで上げる。

## 出典

根拠の決定は次の ADR が持つ。

- [sara は必要なときに上げ、Cargo.lock と flake の input を同じタグに揃える](../adr/sara-upgraded-when-needed.md)

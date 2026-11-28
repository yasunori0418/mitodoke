---
id: "REQ-423d8274-73e8-41d7-93d0-72bb4972e1c0"
type: requirement
name: "item を指定しない verify は、対話で選んだ枝を上流から順にたどって人の確認を記録する"
description: "item を指定しない mitodoke verify は、対話で枝を選ばせ、上流から順に item を表示して人の確認を記録し、表示のビューアとコメントのエディタを mitodoke.yaml で設定できるようにする。"
specification: |
  When no item is given, mitodoke verify SHALL let a person choose a branch of the graph
  interactively, SHALL display the items of the chosen branch in order from upstream, and SHALL
  record a human verification on an item that the person confirms. mitodoke verify SHALL let the
  person enter a comment when recording a verification. The viewer used to display an item and the
  editor used to enter a comment SHALL be configurable in `mitodoke.yaml`.
specification_ja: |
  item を指定しないとき、mitodoke verify は、人に対話でグラフの枝を選ばせ、選んだ枝の item を上流から
  順に表示し、人が確認した item に人の確認を記録しなければならない。mitodoke verify は、確認を記録する
  ときに、人がコメントを入力できるようにしなければならない。item の表示に使うビューアと、コメントの入力に
  使うエディタは、`mitodoke.yaml` で設定できなければならない。
section: commands
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:50:04+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:59:46+09:00"
---
# item を指定しない verify は、対話で選んだ枝を上流から順にたどって人の確認を記録する

## 仕様

- item を指定しない `mitodoke verify` は、人に対話でグラフの枝を選ばせ、選んだ枝の item を上流から順に表示する。人が確認した item に、人の確認を記録する
- 確認を記録するときに、人はコメントを入力できる
- item の表示に使うビューアと、コメントの入力に使うエディタは、`mitodoke.yaml` で設定できる

人の確認を記録してよい実行の条件は
[verify は端末での人の入力があるときだけ人の確認を記録する](human-verification-recording.md)、
`solution` と `use_case` で記録の前に示す確認の問いは
[verify は、solution と use_case の確認を記録する前に確認の問いを表示する](verify-shows-review-questions.md)
が定める。

## 出典

根拠の決定は次の ADR が持つ。

- [item を指定しない verify は、対話で選んだ枝を上流から順にたどり、ビューアとエディタを設定で選べる](../adr/verify-walks-branch-interactively.md)

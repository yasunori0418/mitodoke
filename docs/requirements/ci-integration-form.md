---
id: "REQ-af47f52f-4ff5-4298-8746-6b5e8b76ce52"
type: requirement
name: "CI 連携は CLI と workflow の例で提供する"
description: "CI 連携を CLI と README の workflow の例で提供し、action を配らないことを定める。"
specification: "mitodoke SHALL provide CI integration through its CLI and an example GitHub Actions workflow in the README. The example SHALL install mitodoke with Nix and run mitodoke check, and on pull requests SHALL also run mitodoke fresh against a base revision. mitodoke SHALL NOT distribute a GitHub Action or a reusable workflow. mitodoke's own CI SHALL run in the same form as the example."
specification_ja: "mitodoke は、CI 連携を CLI と README の GitHub Actions の workflow の例で提供しなければならない。例は Nix で mitodoke を入れて mitodoke check を実行し、pull request では基準のリビジョンに対する mitodoke fresh も実行しなければならない。mitodoke は GitHub Actions の action も再利用できる workflow も配ってはならない。mitodoke 自身の CI は例と同じ形で動かさなければならない。"
section: distribution
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:31:23+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:02:33+09:00"
---
# CI 連携は CLI と workflow の例で提供する

## 仕様

mitodoke は、適用先の製品の CI で mitodoke を動かす手段として、CLI と、README に載せる GitHub
Actions の workflow の例を提供する。

- 例では、Nix で mitodoke を入れて `mitodoke check` を実行する。pull request では、
  `mitodoke fresh --base <基準>` も実行する
- GitHub Actions の action（composite action を含む）と、再利用できる workflow は配らない
- mitodoke 自身の CI は、例と同じ形で動かす

## 出典

根拠の決定は次の ADR が持つ。

- [CI 向けには CLI と workflow の例だけを用意し、action は配らない](../adr/ci-integration-by-cli-and-workflow-example.md)

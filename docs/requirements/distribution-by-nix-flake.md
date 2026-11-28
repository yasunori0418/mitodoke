---
id: "REQ-7ec90232-7ec2-414a-a95e-af8d6994340b"
type: requirement
name: "Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配る"
description: "mitodoke を Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配ることを定める。"
specification: "mitodoke SHALL be distributed primarily as a Nix flake. The flake SHALL also distribute the sara CLI built from the same tag as the sara-core that mitodoke embeds."
specification_ja: "mitodoke は Nix flake を主な配布の手段としなければならない。その flake は、mitodoke が組み込む sara-core と同じタグの sara の CLI も一緒に配らなければならない。"
section: distribution
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:57:18+09:00"
---
# Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配る

## 仕様

mitodoke は、Nix flake を主な配布の手段にする。

mitodoke の flake は、sara の CLI も一緒に配る。配る sara の CLI は、mitodoke が組み込む
sara-core と同じタグのものに限る。組み込む版と配る版がずれると、mitodoke の検査と sara の CLI の
検査で結果が食い違うおそれがあるためである。

## 出典

根拠の決定は次の ADR が持つ。

- [Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る](../adr/distributed-by-nix-flake-with-sara-cli.md)

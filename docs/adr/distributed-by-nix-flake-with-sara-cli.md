---
id: "ADR-7707ddc2-ee32-49a1-9316-918fe860394c"
type: adr
name: "Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る"
description: "mitodoke を Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配ると決める。"
section: distribution
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q15）で確定"
justifies:
  - "REQ-7ec90232-7ec2-414a-a95e-af8d6994340b"
references:
  - "ADR-22a2cfdf-7f6f-4315-9a73-d3067684cf8b"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
---
# Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る

- ステータス: stable
- 日付: 2026-11-17
- 関連: [Rust で書き、sara-core を crate として組み込む](rust-cli-embedding-sara-core.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q15）で確定

## 背景

mitodoke を利用者にどう配るかと、mitodoke が組み込む sara-core とは別に、sara の CLI をどう
扱うかを決める必要があった。文書管理のスキルは、`sara check`・`sara query -d`・`sara report`・
`sara init` を直接呼んでいる。

sara のバイナリは GitHub Release に無く、入手先は crates.io・upstream の Nix flake・個人の NUR
である。個人の NUR は upstream の main をタグに固定せずに再 export していて、cachix には
x86_64-linux と aarch64-darwin の分だけを push している。

## 決定

- Nix flake を主な配布にし、`packages.<system>.mitodoke` を cachix に push する
- crates.io への公開は、CLI のサブコマンドと出力が固まってからにする
- sara の CLI は、mitodoke の flake から upstream の flake を再 export して一緒に配る。スキルは、
  `sara query` などを直接呼べる
- 組み込む sara-core と配る sara の CLI は、同じタグに固定する。タグを上げる手順はこの ADR では
  決めない

## 根拠

いまの適用先の製品は、どれも Nix でツールを入れている。まず flake で配れば、適用先は flake の
input に加えるだけで使える。

crates.io に出すと、そのあとで出力を変える変更を出しにくくなる。そのため、サブコマンドと出力が
固まるまで待つ。

sara は意図して採用している外部依存である（コンセプト文書の §8）。item を辿るといった sara の
機能を、mitodoke のサブコマンドとして作り直す必要は無い。

組み込む sara-core と配る CLI のバージョンがずれると、mitodoke の検査と sara の CLI の検査で
結果が食い違うおそれがある。そのため、両方を同じタグに固定する。

## 棄却した代替案

### Nix flake・crates.io・GitHub Release のバイナリを最初から揃える

crates.io に出すと、サブコマンドと出力が固まる前に、出力を変える変更を出しにくくなる。

### Nix flake だけで配り、sara の CLI は配らない

スキルが要る機能（item を辿るなど）を、mitodoke のサブコマンドとして用意する案。sara は意図して
採用している外部依存なので、その機能を作り直す必要が無い。

---
id: "ADR-86388a0f-4ec2-4672-8452-91361d40c716"
type: adr
name: "CI 向けには CLI と workflow の例だけを用意し、action は配らない"
description: "CI 連携のために CLI と README の workflow の例だけを用意し、action は配らないと決める。"
section: distribution
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q30）で確定"
justifies:
  - "REQ-af47f52f-4ff5-4298-8746-6b5e8b76ce52"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:31:28+09:00"
---
# CI 向けには CLI と workflow の例だけを用意し、action は配らない

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q30）で確定

## 背景

適用先の製品の CI で mitodoke を動かす手段を、mitodoke がどこまで用意するかを決める必要があった。

コンセプト文書の §9 は、CI を、自動チェックを実行して契約の違反や再確認が要る状態を明らかにする
ために使うとしている。§10 は、mitodoke が汎用的なテストランナーや CI ログの管理システムになる
ことを非目標にしている。mitodoke は Nix flake で配る。

## 決定

- CLI だけを用意し、README に GitHub Actions の workflow の例を載せる。例では、Nix で mitodoke を
  入れて `mitodoke check` を実行し、pull request では `mitodoke fresh --base <基準>` も加える
- action は配らない
- mitodoke 自身の CI を、例と同じ形で動かす
- action や再利用できる workflow を配ることは、Nix を使わない適用先の製品が現れたときに考える

## 根拠

mitodoke 自身の CI を例と同じ形で動かせば、例が古くなりにくくなる。

いまの適用先の製品は、どれも Nix でツールを入れているので、action を配る具体的な必要はまだ無い
（コンセプト文書の §11 の 10「先回りした抽象化を避ける」）。action を配ると、入力の名前や
バージョンの付け方を、CLI とは別に保守することになる。

## 棄却した代替案

### 薄い composite action を配る

mitodoke を入れて `mitodoke check` を実行する composite action を、mitodoke のリポジトリで配る案。
入力の名前やバージョンの付け方を CLI とは別に保守することになり、いまの適用先の製品にはそれを
配る具体的な必要が無い。Nix を使わない適用先の製品が現れたときに改めて考える。

### 再利用できる workflow を配る

上と同じ理由で採らない。

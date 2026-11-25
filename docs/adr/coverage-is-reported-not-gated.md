---
id: "ADR-32f0bc86-085c-463d-b486-2bfc7ecd5ea0"
type: adr
name: "カバレッジは報告にとどめ、閾値でマージを止めない"
description: "mitodoke 自身の開発で、カバレッジは報告にとどめ、閾値でマージを止めない規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-4643187c-702a-4d53-9efe-b8352938d6d7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T01:17:25+09:00"
---
# カバレッジは報告にとどめ、閾値でマージを止めない

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI を実装する前に、mitodoke 自身の
開発の規範を決める必要があった。#6 のコメントはカバレッジの扱いを、決まっていない規範の候補に挙げて
いた。

## 決定

規範 [カバレッジは報告にとどめ、閾値でマージを止めない](../quality/coverage-reported-without-threshold.md)
を起こす。カバレッジは報告にとどめ、閾値でマージを止めない。

計測のツールと報告の出し方は、この規範では決めない。CI を実装する
子の epic A（テストの区分の `foundation` に当たる範囲）が決める。

## 根拠

- 閾値でマージを止めると、数字を満たすためだけのテストが増える
- テストの不足は `risk` と `test_condition` のつながりの欠けで見つける
- 規範を先に書いておけば、子の epic は CI を実装するときに、何を満たせばよいかを item から読める

## 棄却した代替案

### 閾値を決めてマージを止める

カバレッジの閾値を決め、下回る変更のマージを止める案。数字を満たすためだけのテストが増える。

### カバレッジを計測しない

カバレッジを計測も報告もしない案。計測しないと、テストがどの部分を実行していないかを見る手がかりが無くなる。

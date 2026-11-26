---
id: "ADR-1d7bca51-da71-4f83-93d3-6e1b907036cd"
type: adr
name: "実物のグラフの未カバーは CI で一覧にし、job は失敗にしない"
description: "CI の sara job で実物のグラフへ sara-gap を実行し、未カバーの一覧をログと job のサマリーに出す。該当ありでは job を失敗にせず、実行の失敗か見出しの欠落だけで失敗にする。"
section: verification
status: stable
sources:
  - id: "issue-31"
    resource: "https://github.com/yasunori0418/mitodoke/issues/31"
    title: "epic: 規範とテスト計画を支える仕組みを決める — infrastructure に satisfies されていない quality と、test_plan の支え"
origin: "#31 の grilling（2026-11-26）で確定"
justifies:
  - "INF-dee49f6e-3499-4d26-9a97-2cd6e03a5d0f"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:41:49+09:00"
---

# 実物のグラフの未カバーは CI で一覧にし、job は失敗にしない

- ステータス: stable
- 日付: 2026-11-26
- 関連: [quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す](quality-infrastructure-exempt.md), GitHub Issue #31
- 起点: #31 の grilling（2026-11-26）で確定

## 背景

2026-11-26 の時点で、CI の `sara` job は `sara-gap` の契約テスト（fixture に対する検証）だけを実行し、
実物のグラフには `sara-gap` を実行していなかった。実物のグラフでは `risk` を持たない `requirement` が
41 本あるので、`sara-gap` は exit 1 になる。これは #76 と #77 が終わるまで続き、`test_plan` の到達率は
#6 まで 0 のままである。

## 決定

- CI の `sara` job に、実物のグラフへの `sara-gap` を載せ、結果を報告に留める
- `sara-fresh` と同じ形で、一覧をログと job のサマリーに出す
- 該当あり（exit 1）では job を失敗にせず、実行の失敗（exit 2 以上）か見出しの欠落だけで失敗にする

## 根拠

PR ごとに未カバーの増減が見え、`sara-fresh` と同じ形なので新しい決まりが増えない。

## 棄却した代替案

### 該当ありで job を失敗にする

#76・#77・#6 が終わるまで `sara` job が失敗し続け、ほかの失敗が埋もれる。

### 載せない

#31 の「決めること」の 3 点目を先送りし、0 本にした `quality` の節が後で増えても気づけない。

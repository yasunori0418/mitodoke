---
id: "ADR-05ab6fb0-899b-46e7-a853-82ed1b6857ff"
type: adr
name: "solution と use_case は、確認の問いに人が答える妥当性確認でカバーする"
description: "上位 2 層の solution と use_case は、確認の問いに人が答える妥当性確認でカバーし、risk の threatens の先は広げない。"
section: graph-model
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定"
justifies:
  - "QA-3996a09e-f103-4b91-94b3-82764f97aa0c"
  - "QA-96fe5f3e-37bb-4094-bcf8-b9eeddbcf45b"
  - "REQ-73949e27-20a9-4df4-9265-a7d7048d22fe"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:39:58+09:00"
---
# solution と use_case は、確認の問いに人が答える妥当性確認でカバーする

- ステータス: stable
- 日付: 2026-11-22
- 関連: GitHub Issue #80, `docs/model.yaml`
- 起点: issue #80 の grilling（2026-11-22）で確定

## 背景

保証する連鎖は `requirement` ← `risk` ← `test_condition` ← `test_case` で、`risk` の `threatens` は
`requirement` と `design` にしか張れない。上位 2 層の `solution` と `use_case` には、内容が製品の
進むべき方向を表しているかを確かめる仕組みが無い。

コンセプトの §10 は ISTQB/JSTQB のテストプロセスの考え方とホリスティックテスティングに沿うと宣言
している。どちらも、作ったものが要件どおりかを確かめる検証とは別に、成果物が利用者の本当のニーズを
表しているかを確かめる[妥当性確認](../ubiquitous-language/validation.md)を求める。

## 決定

- `solution` と `use_case` は、[確認の問い](../ubiquitous-language/review-question.md)に人が答える
  妥当性確認でカバーする。`threatens` の先は広げず、保証する連鎖は `requirement` から始める
- 確認の問いは `solution` 用と `use_case` 用に 1 本ずつ `quality` の item として製品に同梱する。
  初期値は、方向性が製品のあるべき形とずれていないか、既存の製品に対する独自の価値があるか、
  作らないと決めたものは何か、の 3 つとする
- 確認の問いを持つ `quality` は任意の enum の `review_question_for`（値は `solution`・`use_case`）で
  見分ける。適用先の製品はこのフィールドを持つ `quality` の item を足して問いを増やす
- 答えはグラフに置かず、答えた事実を `verified` で記録する

## 根拠

製品の方向性、独自の価値、作らないと決めることは、動的なテストではなく人の判断で確かめるもので
ある。上位 2 層に `risk` を張っても、その `risk` を潰す `test_condition` と `test_case` を書けない。

適合は組み込みのモデルで実現する。mitodoke 自身の規範だけで問いを持っても、適用先の製品に届かない。
問いを `quality` の item に置けば型を増やさずに済み、適用先の製品は自分の item で問いを足せる。
答えの中身は製品ごとの判断で、mitodoke は判断しない。

## 棄却した代替案

### 上位 2 層に risk を張る

`threatens` の先を `solution` と `use_case` に広げると、動的なテストで確かめられない懸念にも
`test_condition` と `test_case` を求めることになる。

### 確認の問いを新しい型で表す

型は 12 のまま増やさない。問いは規範なので、`quality` の item で表せる。

### mitodoke 自身の quality だけに問いを書く

mitodoke の規範だけで満たしても、適用先の製品に届かない。

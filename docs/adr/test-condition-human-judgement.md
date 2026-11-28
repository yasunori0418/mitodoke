---
id: "ADR-ca30f8a4-06a3-437f-8d72-8d13a007c580"
type: adr
name: "test_condition に、人が最終的に判断する理由の human_judgement を持たせる"
description: "test_condition に任意の text の human_judgement を足して理由の 1 文を書かせ、機械で確かめるのを既定にして、人が最終的に判断するものだけを一覧にする。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定"
justifies:
  - "QA-05493ea1-6af7-43b6-97bc-051bbb6fd8d1"
  - "REQ-05cc6e6a-6440-429f-8447-16bd7b192d9c"
references:
  - "ADR-bb13e2a5-b2ce-4af9-9148-37f4e92ef050"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:31:16+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:01:31+09:00"
---
# test_condition に、人が最終的に判断する理由の human_judgement を持たせる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [requirement に risk_exempt を設け、理由を書いた requirement を未カバーから外す](requirement-risk-exempt.md), GitHub Issue #80, `docs/model.yaml`
- 起点: issue #80 の grilling（2026-11-22）で確定

## 背景

AI エージェントによる開発の速度を保つには、テストを可能な限り自動に寄せる必要がある。一方で、機械では
合否を決めきれず、人が最終的に判断するテストもある。これまでのモデルでは、どの `test_condition` を人が
判断するのかをグラフから抜き出せなかった。

## 決定

- `test_condition` に任意の text の `human_judgement` を足す。値は、人が最終的に判断する理由の 1 文で、
  `requirement` の `risk_exempt` と同じ形にする
- `test_condition` は機械で確かめるのを既定にし、`human_judgement` を書いたものだけを「人が最終的に
  判断するもの」とする
- `human_judgement` を持つ有効な `test_condition`（`status` が `deprecated` でないもの。`draft` を含む）を一覧にする。一覧は情報で、未カバーには数えない

## 根拠

AI エージェントによる開発の速度を保つには、可能な限り自動テストに寄せ、人が最終的に判断するものだけを
抽出できればよい。印を `test_condition` に置くのは、人が判断するかどうかが、具体的な手順ではなく確かめる
テーマで決まるためである。理由を値にすると、印を付けた理由を読み手が確かめられ、理由の無い印が残らない。

## 棄却した代替案

### 真偽値の印にする

人に回す理由が残らず、機械で確かめられないかを読み手が見直せない。

### 一覧を未カバーに数える

人が判断する `test_condition` は欠けではない。数えると、件数を減らすために印を外す動機が生まれる。

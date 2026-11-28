---
id: "ADR-f78ff526-a3c8-4786-8e07-27f4c06df6c1"
type: adr
name: "main は PR だけで変え、required の check が成功するまでマージしない"
description: "mitodoke 自身の開発で、main を PR だけで変え、required の check が成功するまでマージせず、直接の push、削除、force push を禁じる規範を quality に起こすと決める。"
section: distribution
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "QA-8ec88967-57ce-40aa-957d-ff3c640a44b2"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:47:19+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:30+09:00"
---
# main は PR だけで変え、required の check が成功するまでマージしない

- ステータス: stable
- 日付: 2026-11-24
- 関連: GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

mitodoke は Rust の CLI を開発して配る。CLI を作る #6 の子の epic が CI を実装する前に、mitodoke 自身の
開発の規範を決める必要があった。#6 のコメントは、main のブランチの保護と required の check が、どの
open な Issue にも割り当てられていないと書いていた。

## 決定

規範 [main は PR だけで変え、required の check が成功するまでマージしない](../quality/main-changed-only-by-pull-request-with-required-checks.md)
を起こす。main は PR だけで変え、required の check が成功するまでマージしない。直接の push、削除、
force push を禁じる。

required にする check の名前と、ruleset の設定は、この規範では決めない。CI を実装する
子の epic A（テストの区分の `foundation` に当たる範囲）が決める。

## 根拠

- 検証に成功していない変更が main に入らないことを、規約ではなく設定で守る
- 設定で禁じれば、AI エージェントの誤った push も止まる
- 規範を先に書いておけば、子の epic は CI を実装するときに、何を満たせばよいかを item から読める

## 棄却した代替案

### 規約だけで守り、設定では禁じない

main への直接の push などを規約で禁じるだけにし、リポジトリの設定では禁じない案。規約だけでは
AI エージェントの誤った push を止められない。

### メンテナに bypass を許す

メンテナには、required の check が成功していない変更のマージや、main への直接の push を許す案。
検証に成功していない変更が main に入りうる。

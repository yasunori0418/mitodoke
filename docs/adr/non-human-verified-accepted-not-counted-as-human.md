---
id: "ADR-b9a7b27b-57ea-41cc-9509-126bea9d6d3e"
type: adr
name: "human: 以外の verified も受け付け、基準時刻には数えるが人の確認には数えない"
description: "verified に human: 以外の要素も受け付け、再確認待ちの基準時刻には数えるが、人の確認には数えない。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q24）で確定"
justifies:
  - "QA-aa70fff6-3e0a-4163-bf4c-97f1730f7496"
  - "QA-611977bd-3d11-4695-9fb2-a9f7211fcfbd"
references:
  - "ADR-f27192ea-3ca8-4794-8a6a-805dd8ab323d"
  - "ADR-dfff5637-f0a4-4e5d-a57e-f4dd1e7dbb42"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:02+09:00"
---
# human: 以外の verified も受け付け、基準時刻には数えるが人の確認には数えない

- ステータス: stable
- 日付: 2026-11-17
- 関連: [level が high の risk に人の verified を求める](human-verified-required-for-high-risk.md), [鮮度は上流の relation を辿って下流へ伝播させる](freshness-propagates-along-upstream-relations.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q24）で確定

## 背景

`verified` に `human:` 以外の actor（機械やエージェント）の要素があるとき、mitodoke がどう
扱うかを決める必要があった。

決定の時点のコンセプト文書は、`verified` は人の確認を記録すると書いていた。設計原則の 6 は、
自動化によって人が確認した状態を暗黙に付与してはならないと書く。OKF v0.2 の扱いは違い、
`human:` 以外の actor による確認も、正当な機械の確認として扱う。

写した規範と ADR は、基準時刻を `generated.at` とそれ以降の `verified` の時刻のうち最も新しい
ものとし、`verified` の actor を問わない。一方、人の確認として数えるのは `by` が `human:` で
始まる要素だけである。

## 決定

OKF v0.2 に合わせ、`verified` に `human:` 以外の要素も受け付ける。`human:` 以外の要素は、
再確認待ちの基準時刻には数えるが、人の確認には数えない。

## 根拠

利用者は、`verified` の扱いを OKF v0.2 に合わせることを選んだ。基準時刻には actor を問わず
数え、人の確認には `human:` だけを数える扱いは、写した規範と ADR の判定と同じなので、判定の
規則を変えずに済む。

受け入れた代償は、`human:` 以外の `verified` でも基準時刻が進み、人の目を経ずに再確認待ちから
外れることがある点である。`human:` 以外の要素の時刻が上流の変更より新しければ、その item は
再確認待ちの一覧から消える。人の確認には数えないので、人が確認した状態として扱うことには
ならない。コンセプト文書 §6 は、この決定に合わせて書き直した。

## 棄却した代替案

### verified を人の確認だけに限り、human: 以外の要素を構造の契約の違反にする

推奨だった案。`human:` 以外の要素は `mitodoke check` で失敗にする。推奨の理由は次のとおり。

- コンセプト文書が `verified` を人の確認と定めていたので、機械の要素を受け付けると、同じキーに
  意味の違う記録が並ぶ
- `human:` 以外の要素を受け付けると、エージェントが `verified` に要素を書いても `check` は成功し、
  基準時刻が進む。その時刻が上流の変更より新しければ、再確認の義務が人の目を経ずに消え、
  設計原則の 6 に反する

利用者が OKF v0.2 に合わせる扱いを選んだので採らなかった。

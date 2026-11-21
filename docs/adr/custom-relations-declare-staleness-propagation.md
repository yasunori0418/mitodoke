---
id: "ADR-c715e4e8-b7d5-4729-aa09-ad44bb7214fa"
type: adr
name: "再確認待ちは、設定で宣言した独自の relation も辿る"
description: "再確認待ちの判定は、組み込みの 7 relation に加えて、設定で伝播させると宣言した独自の relation も辿る。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q18）で確定"
justifies:
  - "REQ-73e736ca-7c31-4c0a-9448-80fb29347f1d"
references:
  - "ADR-dfff5637-f0a4-4e5d-a57e-f4dd1e7dbb42"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:32+09:00"
---
# 再確認待ちは、設定で宣言した独自の relation も辿る

- ステータス: stable
- 日付: 2026-11-17
- 関連: [鮮度は上流の relation を辿って下流へ伝播させる](freshness-propagates-along-upstream-relations.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q18）で確定

## 背景

再確認待ちの判定は、上流の relation のうち `justifies` を除く組み込みの 7 relation（`refines`・
`derives_from`・`satisfies`・`threatens`・`mitigates`・`covers`・`follows`）を辿る。

設定で独自の relation を加えられると、その relation を再確認待ちの判定で辿るかを決めなければ
ならない。sara の model.yaml では relation の逆向きの名前や向きを定義できるが、再確認待ちの
判定に使う relation を指定する口は無い。判定に使う relation は mitodoke が決める。

## 決定

再確認待ちの判定では、組み込みの 7 relation に加えて、設定で「伝播させる」と宣言した独自の
relation も辿る。宣言の無い独自の relation は辿らない。

## 根拠

独自の relation でも、宣言すれば再確認待ちを伝播させられる。独自の relation でつないだ下流も、
上流が変わったときに報告の対象にできる。

独自の relation を判定に自動では加えず、宣言を求めるのは、上流を向く relation でも、再確認待ちを
伝播させたくないものがあるからである。組み込みの relation でも、`justifies` は上流を向くが、
再確認待ちの判定では辿らない。宣言を求めることは grilling で推奨した側の判断で、コンセプト文書に
根拠は無い。

## 棄却した代替案

### 独自の relation には sara の構造の検査だけを働かせる

mitodoke の検査は組み込みの型と relation だけを見て、独自の relation には参照先の有無・循環・
接続漏れなどの sara の構造の検査だけを働かせる案。再確認待ちの判定に独自の relation が入らない
ので、独自の relation でつないだ下流は、上流が変わっても再確認待ちとして挙がらない。

---
id: "TP-cefb0111-5c50-4f89-8955-b63b3c5904c8"
type: test_plan
name: "sara の挙動に依る検査は、mitodoke の結果を期待にして受け入れテストで確かめる"
description: "sara の挙動の回帰を別のレベルにせず、sara の挙動に依る検査は、sara の挙動を確かめた実験の入力を受け入れテストの fixture にして mitodoke の結果を期待にし、sara-core 自体が何を返すかは確かめない。"
specification: |
  The test process SHALL NOT set up a separate test level for regressions in the behavior of sara.
  The acceptance tests SHALL use as fixtures the inputs of the experiments that checked the
  behavior of sara (a test_case without covers, an undeclared key, OKF values of a wrong shape, an
  item that has only an inverse relation, and mutual references), and SHALL check the results of
  mitodoke as the expectations. The test process SHALL NOT check what sara-core itself returns.
specification_ja: |
  テストプロセスは sara の挙動の回帰のために別のテストのレベルを立ててはならない。受け入れテストは、
  sara の挙動を確かめた実験の入力（covers の無い test_case、宣言の無いキー、形の合わない OKF の値、
  逆向きの relation だけを持つ item、相互の references）を fixture にし、mitodoke の結果を期待として
  確かめなければならない。テストプロセスは sara-core 自体が何を返すかを確かめてはならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:09:18+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:07:20+09:00"
---
# sara の挙動に依る検査は、mitodoke の結果を期待にして受け入れテストで確かめる

## 仕様

sara の挙動の回帰は別のテストのレベルにしない。

[#6 のコメントの 3.1 節](https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024)の
実験の入力を受け入れテストの fixture にし、mitodoke の結果を期待として確かめる。入力は次のとおりである。

- `covers` の無い `test_case`
- 宣言の無いキー
- 形の合わない OKF の値
- 逆向きの relation だけを持つ item
- 相互の `references`

sara-core 自体が何を返すかは確かめない。

## 出典

根拠の決定は次の ADR が持つ。

- [sara の挙動の回帰は別のレベルにせず、mitodoke の結果で確かめる](../adr/sara-behavior-checked-through-mitodoke-results.md)

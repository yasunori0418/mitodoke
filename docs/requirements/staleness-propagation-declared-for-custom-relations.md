---
id: "REQ-73e736ca-7c31-4c0a-9448-80fb29347f1d"
type: requirement
name: "独自の relation は、再確認待ちを伝播させるかを設定で宣言する"
description: "再確認待ちの判定は、組み込みの 7 relation に加えて、設定で伝播させると宣言した独自の relation も辿る。"
specification: |
  When mitodoke determines which items are stale, it SHALL follow the seven built-in
  relations that propagate staleness and, in addition, every custom relation that the
  configuration file declares as propagating staleness. It SHALL NOT follow a custom relation
  that the configuration file does not declare as propagating. The configuration file SHALL
  allow each custom relation to declare whether it propagates staleness.
specification_ja: |
  mitodoke は、再確認待ちの item を判定するとき、再確認待ちを伝播させる組み込みの 7 relation に
  加えて、設定ファイルで伝播させると宣言した独自の relation も辿らなければならない。設定ファイルで
  伝播させると宣言していない独自の relation は辿ってはならない。設定ファイルは、独自の relation
  ごとに、再確認待ちを伝播させるかを宣言できなければならない。
section: model-config
status: stable
derives_from:
  - "UC-12a8f452-5377-4e63-8e38-4ddda1be8e72"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:14+09:00"
---
# 独自の relation は、再確認待ちを伝播させるかを設定で宣言する

## 仕様

mitodoke は、再確認待ちの item を判定するとき、組み込みの 7 relation に加えて、設定ファイルで
伝播させると宣言した独自の relation も辿る。宣言の無い独自の relation は辿らない。

- 設定ファイルは、独自の relation ごとに、再確認待ちを伝播させるかを書ける
- 宣言していない独自の relation は、上流を向いていても再確認待ちを伝播させない

## 出典

根拠の決定は次の ADR が持つ。

- [再確認待ちは、設定で宣言した独自の relation も辿る](../adr/custom-relations-declare-staleness-propagation.md)

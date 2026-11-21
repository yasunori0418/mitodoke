---
id: "REQ-008c2404-ff49-4d36-a72b-df7e193cee2e"
type: requirement
name: "製品は CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含む"
description: "mitodoke の製品は CLI とモデルに加えて文書管理の規範・スキル・欠陥運用の規範を含み、開発の進め方の規範と DoD は含まない"
specification: |
  The mitodoke product SHALL include, in addition to the CLI and the model, the norms of
  document management, skills, and the norm for handling defects. The product SHALL NOT
  include norms on how a particular product is developed (such as comment conventions or
  formatting), norms tied to a particular product, or a definition of done.
specification_ja: |
  mitodoke の製品は、CLI とモデルに加えて、文書管理の規範・スキル・欠陥運用の規範を
  含まなければならない。製品は、特定の製品の開発の進め方の規範（コメント規約や整形など）、
  特定の製品に結びついた規範、DoD を含んではならない。
section: product-scope
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:32+09:00"
---
# 製品は CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含む

## 仕様

利用者が mitodoke を自分の製品に導入するとき、受け取る物は次のとおり。

- CLI
- モデル
- 文書管理の規範（ID・ADR・risk の採点・テスト系 item の粒度・鮮度など、文書管理の決まりを
  述べる quality item）
- スキル
- 欠陥運用の規範

スキルの本数と名前は、この要件では定めない。スキルの範囲は GitHub Issue #46 で決める。

文書管理の機構ではないものは含めない。特定の製品の開発の進め方を定める規範（コメント規約や
整形など）、特定の製品に結びついた規範、DoD がこれにあたる。

## 出典

根拠の決定は次の ADR が持つ。

- [製品に CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含める](../adr/product-bundles-cli-model-norms-skills.md)

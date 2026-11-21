---
id: "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
type: requirement
name: "検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は報告とし、どの検査の強さも設定で変えられるようにする。"
specification: |
  By default, a violation of a structural contract SHALL be a failure. The structural
  contracts SHALL include `sara check`, the shape of the frontmatter, the placement of IDs,
  the one-to-one correspondence between test_case items and test assets, the derivation of
  a risk's `level`, the `deprecated` status of a `supersedes` target, and the difference in
  `index.md`. By default, a connection gap and a review obligation SHALL be reported without
  failing. The connection gaps SHALL include a test_condition that is not covered, a risk
  that is not mitigated, a requirement that is not threatened, and a quality that is not
  satisfied. The review obligations SHALL include an item awaiting review after an upstream
  change, a missing `generated` update, and a high risk lacking a human verification. The
  strength of every inspection SHALL be changeable in the configuration.
specification_ja: |
  既定では、構造の契約の違反は失敗としなければならない。構造の契約には、`sara check`、
  frontmatter の形、ID の置き場所、test_case とテスト資産の 1:1、risk の `level` の導出、
  `supersedes` の先が `deprecated` であること、`index.md` の差分を含めなければならない。
  既定では、つながりの欠けと見直しの義務は、失敗にせずに報告しなければならない。つながりの
  欠けには、covers されない test_condition、mitigates されない risk、threatens されない
  requirement、satisfies されない quality を含めなければならない。見直しの義務には、上流の
  変更による再確認待ち、generated の更新漏れ、人の確認が無い high の risk を含めなければ
  ならない。どの検査の強さも、設定で変えられなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:30:47+09:00"
---
# 検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる

## 仕様

mitodoke の検査は、構造の契約、つながりの欠け、見直しの義務の 3 つに分かれる。既定では、
構造の契約の違反だけを失敗にし、つながりの欠けと見直しの義務は CI で報告する。

- 構造の契約: `sara check`、frontmatter の形、ID の置き場所、test_case とテスト資産の 1:1、
  risk の `level` の導出、`supersedes` の先が `deprecated` であること、`index.md` の差分
- つながりの欠け: covers されない test_condition、mitigates されない risk、threatens されない
  requirement、satisfies されない quality
- 見直しの義務: 上流の変更による再確認待ち、generated の更新漏れ、人の確認が無い high の risk

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、適用先の製品が決める。

## 出典

根拠の決定は次の ADR が持つ。

- [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする](../adr/default-strength-fail-structure-report-gaps.md)

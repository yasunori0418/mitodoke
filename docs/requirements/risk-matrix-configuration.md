---
id: "REQ-cfa09935-9066-433a-a3ef-05ca83ad9a22"
type: requirement
name: "level の導出表は設定で変えられ、設定が無ければ既定の表を使う"
description: "risk の level を likelihood と impact から導く表は設定で変えられ、設定に無ければ既定の表を使い、値の集合は製品で固定する。"
specification: |
  The `level` of a risk SHALL be the level that the derivation table gives for its
  `likelihood` and `impact`. mitodoke SHALL use the derivation table that the configuration
  file defines, and SHALL use the default table when the configuration file defines none. The
  default table SHALL be the table of the norm
  [risk の level は likelihood と impact から導き、手で決めない](../quality/risk-level-derived-from-likelihood-and-impact.md),
  which maps each of the nine pairs of `likelihood` and `impact` to a `level`. The
  configuration file SHALL be able to change only the mapping from a pair of `likelihood` and
  `impact` to a `level`. The sets of values of `likelihood`, `impact` and `level` (low, medium
  and high) SHALL be fixed by the product and SHALL NOT be changed by the configuration file.
specification_ja: |
  risk の `level` は、導出表がその `likelihood` と `impact` に対応させる値でなければならない。
  mitodoke は、設定ファイルが定める導出表を使わなければならず、設定ファイルが導出表を定めて
  いなければ既定の表を使わなければならない。既定の表は、規範
  [risk の level は likelihood と impact から導き、手で決めない](../quality/risk-level-derived-from-likelihood-and-impact.md)
  の表で、`likelihood` と `impact` の 9 通りの組のそれぞれを `level` に対応させるもので
  なければならない。設定ファイルで変えられるのは、`likelihood` と `impact` の組から `level` への
  対応だけでなければならない。`likelihood`・`impact`・`level` の値の集合（low・medium・high）は
  製品で固定しなければならず、設定ファイルで変えてはならない。
section: model-config
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:33+09:00"
---
# level の導出表は設定で変えられ、設定が無ければ既定の表を使う

## 仕様

risk の `level` は、導出表がその `likelihood` と `impact` に対応させる値と一致させる。導出表には
設定ファイルの表を使う。

- 設定ファイルに導出表が無ければ、既定の表を使う。既定の表は、
  [risk の level は likelihood と impact から導き、手で決めない](../quality/risk-level-derived-from-likelihood-and-impact.md)
  の表で、`likelihood` と `impact` がそれぞれ low・medium・high の 9 通りの組に `level` を対応させる
- 設定ファイルで変えられるのは、`likelihood` と `impact` の組から `level` への対応だけとする
- `likelihood`・`impact`・`level` の値の集合（low・medium・high）は製品で固定し、設定ファイルでは
  変えられない

## 出典

根拠の決定は次の ADR が持つ。

- [level の導出表を設定で変えられるようにし、値の集合は固定する](../adr/risk-matrix-configurable-values-fixed.md)

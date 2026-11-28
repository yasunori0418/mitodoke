---
id: "UBQ-33d754f3-ef63-45bc-b3e4-c2e514772f7d"
type: ubiquitous_term
name: "inspection strength"
description: "検査の指摘をどう扱うかを決める設定の値。"
name_ja: "検査の強さ"
section: inspection
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:53+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:18:23+09:00"
---
# inspection strength

## Definition

The setting that decides how a finding of an inspection is treated. It takes one of two
values: failure (失敗), which makes the inspection fail, and report (報告), which lists the
finding without failing. By default a violation of a structural contract is a failure,
and a missing connection and a review obligation are reports. The strength of every
inspection can be changed by configuration.

## 定義

検査の指摘をどう扱うかを決める設定の値。値は 2 つで、「失敗」は検査を失敗させ、「報告」は指
摘を列挙するだけで失敗させない。既定では、構造の契約の違反が失敗、つながりの欠けと見直しの義
務が報告になる。どの検査の強さも、設定で変えられる。

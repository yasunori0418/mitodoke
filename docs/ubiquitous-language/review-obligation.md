---
id: "UBQ-19901274-2994-49a5-8bca-3e903fe0318b"
type: ubiquitous_term
name: "review obligation"
description: "検査の 3 つの分類の 1 つで、人が読み直すか確かめるかをまだ済ませていない item を見つけるもの。"
name_ja: "見直しの義務"
section: inspection
status: stable
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:55:53+09:00"
---
# review obligation

## Definition

One of the three categories of inspection: a check that finds items a person has yet to
read again or confirm. It covers an item that is stale because an upstream item changed,
an item whose body changed without `generated` being updated, and a risk whose `level`
is high and that has no human verification. By default a review obligation is reported
and does not fail; whether anything needs to change is judged by a person.

## 定義

検査の 3 つの分類の 1 つで、人が読み直すか確かめるかをまだ済ませていない item を見つけるもの。
上流の item の変更による再確認待ち、本文を変えたのに `generated` を更新していない item、人の
確認が無い `level` が high のリスクを含む。既定では、見直しの義務は報告に留め、失敗にしない。
変える必要があるかは人間が判断する。

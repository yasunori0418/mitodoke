---
id: "UC-d33d915a-03ff-4cf6-94f2-a2a01ec6c39b"
type: use_case
name: "出来事をグラフに記録する"
description: "利用者が、テストの実行の記録、観測の結果、欠陥、受け取ったフィードバックといった出来事を item としてグラフに記録する。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:07:32+09:00"
---
# 出来事をグラフに記録する

> **棄却**: この提案は採らない。グラフが持つのは規範で、出来事は持たない。テストの実行の記録、観測の結果、
> 欠陥、受け取ったフィードバックはグラフの外に置き、そこから学んだことだけを上流の item へ追補する。決定は
> 次の ADR にある。
>
> - [ループの右側には型も relation も足さず、既存の型に規範を置く](../adr/right-side-of-loop-adds-no-types.md)
> - [欠陥はグラフに置かず GitHub Issues で管理する](../adr/defects-in-github-issues.md)
> - [欠陥とフィードバックから学んだことを上流の item へ追補する](../adr/defect-and-feedback-backfill-upstream.md)
> - [item にできない外部参照は text フィールドへ逃がす](../adr/external-references-as-text-fields.md)

## 提案した使われ方

利用者は開発とテストの中で起きた出来事を、item としてグラフに記録する。記録するのは、テストの実行の
記録、デプロイやリリースのあとの観測の結果、見つけた欠陥、利用者から受け取ったフィードバックである。
欠陥や議論を記録した Issue も、item としてグラフへ取り込む。利用者は出来事の item から要件やテストの
item へ relation を張り、どの出来事がどの規範に関わるかをグラフで辿る。

## 作らない理由

出来事は時間とともに増え続ける。グラフに置くと、規範の item と同じ扱いで並び、上流の変更を下流へ伝える
鮮度の比較に使えなくなる。出来事の記録、状態の遷移、修正作業の追跡は、Issue のトラッカーやホスティング
サービスの CI のログが持つ。Issue を item として取り込むと、GitHub にある内容を二重に管理することになる。

出来事から学んだことは、規範として既存の型の item に戻せる。観測できるようにすることは `requirement` に、
デプロイやリリースで行うテストは `test_case` に、フィードバックを上流へ戻す手順は `quality` に置く。

## 出典

- [ループの右側には型も relation も足さず、既存の型に規範を置く](../adr/right-side-of-loop-adds-no-types.md)
- [欠陥はグラフに置かず GitHub Issues で管理する](../adr/defects-in-github-issues.md)
- [欠陥とフィードバックから学んだことを上流の item へ追補する](../adr/defect-and-feedback-backfill-upstream.md)
- [item にできない外部参照は text フィールドへ逃がす](../adr/external-references-as-text-fields.md)

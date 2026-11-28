---
id: "ADR-bfda5e90-9084-432d-851a-c73a2c49c021"
type: adr
name: "欠陥とフィードバックから学んだことを上流の item へ追補する"
description: "欠陥 issue のクローズ前にテスト系 item の欠落を追補し、利用者のフィードバックを受けたら確認の問いで solution と use_case を読み直す。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定。欠陥 issue のクローズ時にテスト系 item の欠落を追補する ADR を書き直した"
justifies:
  - "QA-87b7776a-9ece-42ac-9a56-78daacb42217"
supersedes:
  - "ADR-9bec5976-67cd-407a-afa9-3d394a6204ca"
references:
  - "ADR-49733f2e-ed79-480d-bfb9-6361a7f95aed"
  - "ADR-2457aa00-fab7-4c99-af53-2e6643c21c79"
  - "ADR-6d3106b8-3c75-4644-bd15-fc73da1de848"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:56:13+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:24:58+09:00"
---
# 欠陥とフィードバックから学んだことを上流の item へ追補する

- ステータス: stable
- 日付: 2026-11-22
- 関連: [欠陥 issue のクローズ時にテスト系 item の欠落を追補する](defect-close-backfills-risks.md), [欠陥はグラフに置かず GitHub Issues で管理する](defects-in-github-issues.md), [model.yaml で組み込みモデルを全面置換し、汎用の型名を使う](model-yaml-full-replacement.md), [ループの右側には型も relation も足さず、既存の型に規範を置く](right-side-of-loop-adds-no-types.md), GitHub Issue #80, `docs/agents/issue-tracker.md`
- 起点: issue #80 の grilling（2026-11-22）で確定。欠陥 issue のクローズ時にテスト系 item の欠落を追補する ADR を書き直した

## 背景

[欠陥はグラフに置かず GitHub Issues で管理する](defects-in-github-issues.md)。グラフの
risk / test_condition は予防の体系だが、起きた欠陥から学ばなければ、ある時点の分析を写したまま古びていく。

ホリスティックテスティングのループの右側の Learning は、利用者のフィードバックを次の Discovery に戻す。
グラフの上位 2 層の `solution` と `use_case` は[確認の問い](../ubiquitous-language/review-question.md)に人が
答える[妥当性確認](../ubiquitous-language/validation.md)でカバーするが、フィードバックを受けたときに読み直す
決まりは無かった。

## 決定

- 欠陥 issue をクローズする前に、その欠陥を事前に捕まえられたはずの risk / test_condition が欠けて
  いなかったかを検討する。欠けていれば、その item を `docs/` に追補する
- 利用者のフィードバックを受けたら、それが関わる `solution` と `use_case` を確認の問いで読み直す。方向性や
  要求がずれていれば item を直し、読み直した事実を人の確認として記録する
- 受け取ったフィードバックそのものはグラフに置かない
- 手順は `docs/agents/issue-tracker.md` に置く

## 根拠

欠陥の記録はグラフの外に置くが、欠陥から得た教訓は規範としてグラフへ戻す必要がある。フィードバックも
同じで、出来事はグラフの外に置き、そこから得た教訓だけを上流の item に戻す。確認の問いは上位 2 層を
読み直すための問いなので、フィードバックを受けたときにもそのまま使える。

## 棄却した代替案

### 追補を検討せずに欠陥 issue をクローズする

risk / test_condition が起きた欠陥から更新されず、ある時点の分析を写したまま古びていく。

### フィードバックを item として記録する

フィードバックは出来事で、グラフが持つのは規範である。教訓だけを上流の item に戻せば足りる。

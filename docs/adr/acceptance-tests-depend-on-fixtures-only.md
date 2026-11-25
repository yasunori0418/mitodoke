---
id: "ADR-8188dbd5-87b5-414a-abfb-bfcaa5540ddf"
type: adr
name: "受け入れテストは fixture だけに依り、実物のモデルを重ねない"
description: "mitodoke の受け入れテストの fixture は自分の mitodoke.yaml を持って実物の docs/model.yaml を重ねず、実物の文書は mitodoke 自身の文書に対する mitodoke check で別に確かめる。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "TP-8c2f612e-bc08-438f-a6cd-9b73028084b7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:05:34+09:00"
---
# 受け入れテストは fixture だけに依り、実物のモデルを重ねない

- ステータス: stable
- 日付: 2026-11-24
- 関連: [写した契約テストを CLI の受け入れテストにする](contract-tests-as-cli-acceptance-tests.md), [model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md), [risk の節はテストの区分と同じ語彙にする](risk-sections-follow-test-categories.md), GitHub Issue #30, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

写した契約テストのうち `sara-new`・`sara-gap`・`sara-fresh` は、実物の `docs/model.yaml` を fixture に
重ねて動く。`okf-index` のテストは実物の `index.md` と生成結果の一致も確かめる。そのため、`section` の
値を変えるとテストの値も変わり、model.yaml を `mitodoke.yaml` から生成する形に変えると、fixture と
期待値も変わる。

写した契約テストを CLI の受け入れテストにするとき、fixture と実物のモデルのどちらに依るかを決める必要が
あった。

## 決定

受け入れテストは fixture だけに依る。fixture は自分の `mitodoke.yaml` を持ち、実物の `docs/model.yaml`
を重ねない。実物の文書は mitodoke 自身の文書に対する `mitodoke check` で別に確かめる。

## 根拠

実物のモデルの `section` の値を変えるたびに受け入れテストが失敗する、今の形をやめるためである。

risk の `section` とテストの区分の一致を契約テストで確かめる今の検査は、model.yaml を設定から生成する
形（#30）になれば要らなくなる。

## 棄却した代替案

### 実物の設定を fixture に重ねる

実物の `mitodoke.yaml` を fixture に重ねる今の形を引き継ぐ案。実物の設定で CLI が動くことを、受け入れ
テストでも確かめられる。実物のモデルの `section` の値を変えるたびに、受け入れテストが失敗する。

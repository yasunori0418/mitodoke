---
id: "ADR-7c39c22a-9e11-41a6-b847-9270ba57539e"
type: adr
name: "テスト系 item を CASE・TC・RISK の 3 段で起こし、人が行うテストも CASE にする"
description: "CASE はテスト資産、TC は検証テーマ、RISK は TC を束ねる脅威の単位で起こし、人が行うテストも手順書かテストチャーターを resource で指す CASE として起こす"
section: risk-test-defect
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定。テスト系 item を CASE・TC・RISK の 3 段で起こす ADR を書き直した"
justifies:
  - "QA-bf975ac7-1e84-4f75-9fe7-8d6154d69ba1"
  - "REQ-3e39ec3b-6f45-4b66-a31a-0b9d489a0076"
supersedes:
  - "ADR-7631120c-0006-4394-a9cc-32d2f386a67d"
references:
  - "ADR-ca30f8a4-06a3-437f-8d72-8d13a007c580"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:53:51+09:00"
---
# テスト系 item を CASE・TC・RISK の 3 段で起こし、人が行うテストも CASE にする

- ステータス: stable
- 日付: 2026-11-22
- 関連: [テスト系 item を CASE・TC・RISK の 3 段で起こす](test-items-in-three-tiers.md), [test_condition に、人が最終的に判断する理由の human_judgement を持たせる](test-condition-human-judgement.md), GitHub Issue #80, `dev/tests/test-doc-map.sh`
- 起点: issue #80 の grilling（2026-11-22）で確定。テスト系 item を CASE・TC・RISK の 3 段で起こす ADR を書き直した

## 背景

テスト系 item を CASE・TC・RISK の 3 段で起こす決定は、CASE を単独で実行できるテスト資産の単位にしていた。
人が行うテストには実行できるファイルが無く、この定義では CASE として起こせなかった。そのため、人が判断する
テストは、グラフのどこにも対応する item を持てなかった。

コンセプトの §10 が沿うと宣言する ISTQB のテストプロセスとホリスティックテスティングは、どちらも人が行う
テストを含む。

## 決定

- CASE はテストファイル・e2e シナリオ・flake check の単位で起こし、テスト関数の単位には割らない。
  CASE とテスト資産を 1 対 1 にする
- 人が行うテストも CASE として起こし、`resource` で手順書かテストチャーターのファイルを指す。`covers` と
  `follows` の必須は保つ
- [テスト資産](../ubiquitous-language/test-asset.md)の定義から「単独で実行できる」を外し、手順書と
  テストチャーターのファイルを含める。手順書とテストチャーターは「コミットしたファイル」の経路でテスト資産の
  一覧に載せ、種別は手順書とテストチャーターの 2 つの値で表す
- テストの実施の記録はグラフに置かない
- TC は検証テーマの単位で起こし、同じ不変条件・観点を検証する CASE 群を束ねる
- RISK は TC を束ねる脅威の単位で起こし（対象あたり 2〜5 件）、`requirement` / `design` への
  `threatens` で表す
- テストレベルとテストタイプは組み込みのモデルに入れない。手順書とテストチャーターの置き場所の
  ディレクトリも、この決定では決めない

## 根拠

テスト資産の単位にする根拠は、CASE と資産が 1 対 1 になり、資産の追加やリネームに CASE が追従して
いるかを契約テストで確かめられることにある。人が行うテストも手順書かテストチャーターのファイルを資産に
すれば、同じ 1 対 1 の確かめ方がそのまま使える。

実施の記録は出来事で、グラフが持つのは規範である。記録をグラフに置くと、実施のたびに item が変わり、
鮮度の比較に使えなくなる。

テストレベルとテストタイプの扱いと、手順書とテストチャーターの置き場所は、別の issue（#75）で決める。

## 棄却した代替案

### テスト関数の単位で CASE を起こす

CASE が 200 件を超え、ファイル単位のテスト資産とも 1 対 1 にならない。

### 人が行うテストを CASE にせず、test_condition の散文に書く

人が行うテストだけが `covers` と `follows` を持たず、`test_plan` から辿れなくなる。

### 人が行うテストに新しい型を設ける

型は 12 のまま増やさない。手順書とテストチャーターも、テスト資産として CASE が指せる。

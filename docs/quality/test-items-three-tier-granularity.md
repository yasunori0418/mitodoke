---
id: "QA-bf975ac7-1e84-4f75-9fe7-8d6154d69ba1"
type: quality
name: "テスト系 item は、テスト資産・検証テーマ・脅威の 3 段の粒度で起こす"
description: "テスト系 item は CASE をテスト資産・TC を検証テーマ・RISK を脅威の単位で起こし、人が行うテストも CASE にする"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
specification: |
  A `test_case` SHALL be raised one per test asset (the unit of a test's substance, such as a
  test file, a test scenario, or the procedure or test charter file of a test that a person
  performs). A test that a person performs SHALL also be raised as a `test_case`, and its
  `resource` SHALL point to the procedure or test charter file. A `test_condition` SHALL be
  raised per verification theme, and a `risk` SHALL be raised per threat that groups
  `test_condition`s.
specification_ja: |
  `test_case` はテスト資産（テストファイル、テストシナリオ、人が行うテストの手順書かテストチャーターの
  ファイルのような、テストの実体の単位）1 つにつき 1 件で起こさなければならない。人が行うテストも
  `test_case` として起こさなければならず、その `resource` は手順書かテストチャーターのファイルを指さなければ
  ならない。`test_condition` は検証テーマごとに、`risk` は `test_condition` を束ねる脅威ごとに起こさなければ
  ならない。
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-24T23:03:56+09:00"
---
# テスト系 item は、テスト資産・検証テーマ・脅威の 3 段の粒度で起こす

## 仕様

既存のテスト実装から item を起こすときは、次の 3 段の単位で起こす。「対象」は
`docs/test/<対象>/` の区分を指す。区分の一覧と並び順は `dev/tests/test-categories.tsv` が持つ。

- CASE はテスト資産（テストファイルやテストシナリオ）の単位で起こす。frontmatter の
  `resource`（必須・単一値）に対象を正準表記で書き、人間向けの補足は本文の `## 対象` 節に書く。
  主な検証内容（テスト関数のテーマの列挙）も本文に書く。テスト関数の単位には割らない。
  CASE とテスト資産が 1 対 1 であることは `dev/tests/test-doc-map.sh` が強制する
- 人が行うテストも CASE として起こし、`resource` で手順書かテストチャーターのファイルを指す。人が行う CASE
  でも `covers` と `follows` は必須で、実施の記録はグラフに置かない
- TC は検証テーマの単位で起こす（対象あたり数件）。同じ不変条件・観点を検証する CASE 群を
  束ねる
- RISK は TC を束ねる脅威の単位で起こす（対象あたり 2〜5 件）。「このテーマが壊れると何が
  起きるか」を、`requirement` / `design` への `threatens` で表す

関係の向きは次のとおり。

- CASE -`covers`→ TC -`mitigates`→ RISK -`threatens`→ REQ / DSG
- CASE -`follows`→ TP

## 出典

根拠の決定は次の ADR が持つ。

- [テスト系 item を CASE・TC・RISK の 3 段で起こし、人が行うテストも CASE にして、手順書とテストチャーターは列挙のコマンドからも一覧に載せる](../adr/test-items-in-three-tiers-with-human-tests-from-any-source.md)

この item は [layat の同じ slug の item](https://github.com/yasunori0418/layat/blob/97ec53ae73d8f609e7a7c53feeb1baf6909fd76d/docs/quality/test-items-three-tier-granularity.md) を写し、製品の形態に依らない文面に
直したもの。layat での運用の経緯は、原本の出典が持つ。

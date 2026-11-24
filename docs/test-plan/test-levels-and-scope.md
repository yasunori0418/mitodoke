---
id: "TP-8c2f612e-bc08-438f-a6cd-9b73028084b7"
type: test_plan
name: "mitodoke 自身のテストは 7 つの区分に分け、単体のテストと受け入れテストの 2 つのレベルで確かめる"
description: "mitodoke 自身のテストを 7 つの区分に分けて単体のテストと受け入れテストの 2 つのレベルで確かめ、受け入れテストは fixture だけに依って、写した契約テストの期待 141 行のうち 110 行を引き継ぐ。"
specification: |
  The test process SHALL divide the tests of mitodoke itself into seven test categories, in this
  order: foundation, config-model, authoring, inspection, freshness, result-handoff and
  distribution. The test process SHALL have two test levels, unit tests and acceptance tests. Unit
  tests SHALL check the modules inside the crate and SHALL be run by cargo test. Acceptance tests
  SHALL run the built binary against fixture repositories, and an end-to-end test SHALL be treated
  as an acceptance test. Tests that use different models SHALL run in separate processes, and a
  unit test that installs a model SHALL be placed in a separate test binary for each model. The
  acceptance tests of verify, and of new when it takes the human identifier from the configured
  command, SHALL run on a pseudo-terminal. The acceptance tests SHALL depend only on fixtures; each
  fixture SHALL have its own mitodoke.yaml and SHALL NOT overlay the real docs/model.yaml. The real
  documents SHALL be checked separately by mitodoke check run against mitodoke's own documents. Of
  the 141 expectations of the copied contract tests, the acceptance tests SHALL take over the 110
  that the table in the body marks as taken over. The expectations that check only the headings
  and the line format of the text output, those that replace sara with a fake one, those that
  read the real docs/ and expect no violations, and the one that depends on the actual current
  time SHALL NOT be taken over. The acceptance tests SHALL check, with an empty-graph fixture, that
  a graph with no items yields exit code 0. term-avoid.sh SHALL NOT be made an acceptance test and
  SHALL remain a check of mitodoke's own repository. Safety SHALL be the only quality
  characteristic for which no risk is raised. The procedures of mitodoke itself SHALL be placed
  under tests/manual/procedures/ and its test charters under tests/manual/charters/, and they
  SHALL be listed in the test asset inventory by the enumeration command, following
  [テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](../requirements/test-asset-inventory-sources.md).
  The two directories SHALL be created when the first file is placed in them.
specification_ja: |
  テストプロセスは mitodoke 自身のテストを foundation・config-model・authoring・inspection・
  freshness・result-handoff・distribution の 7 つの区分に、この順で分けなければならない。テストの
  レベルは単体のテストと受け入れテストの 2 つとしなければならない。単体のテストは crate の中の
  モジュールを確かめ、cargo test で流さなければならない。受け入れテストはビルドしたバイナリを
  fixture のリポジトリに対して実行しなければならず、e2e テストは受け入れテストとして扱わなければ
  ならない。別のモデルを使うテストはプロセスを分けなければならず、単体のテストのうちモデルを
  install するテストは、モデルごとに別のテストバイナリに置かなければならない。verify と、new が
  設定のコマンドから人の識別子を取る場合の受け入れテストは、疑似端末で流さなければならない。
  受け入れテストは fixture だけに依らなければならず、fixture は自分の mitodoke.yaml を持ち、実物の
  docs/model.yaml を重ねてはならない。実物の文書は mitodoke 自身の文書に対する mitodoke check で
  別に確かめなければならない。受け入れテストは写した契約テストの期待 141 行のうち、本文の表で
  引き継ぐとした 110 行を引き継がなければならない。text 出力の見出しと行の形式だけを確かめる
  期待、偽の sara に差し替える期待、実物の docs/ を読んで違反が 0 件であることを確かめる期待、
  実際の現在時刻に依る期待は、引き継いではならない。受け入れテストは item が 0 件のグラフで
  exit code 0 になることを、空のグラフの fixture で確かめなければならない。term-avoid.sh は受け入れ
  テストにしてはならず、mitodoke 自身のリポジトリの検査として残さなければならない。risk を起こさ
  ない品質特性は safety だけとしなければならない。mitodoke 自身の手順書は tests/manual/procedures/
  に、テストチャーターは tests/manual/charters/ に置かなければならず、
  [テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](../requirements/test-asset-inventory-sources.md)
  に沿って、列挙のコマンドでテスト資産の一覧に載せなければならない。2 つのディレクトリは最初の
  ファイルを置くときに作らなければならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:06:59+09:00"
---
# mitodoke 自身のテストは 7 つの区分に分け、単体のテストと受け入れテストの 2 つのレベルで確かめる

## 仕様

### テストの区分

mitodoke 自身のテストは次の 7 つの区分に分ける。並び順もこのとおりにする。区分の一覧は
`dev/tests/test-categories.tsv` が持つ。

| 区分 | 範囲 |
| --- | --- |
| `foundation` | sara-core を呼ぶこと、読み込みを 1 つにまとめること、設定ファイルの探し方、エンベロープとコードの共通の形、時刻の扱い、端末からの実行の判定 |
| `config-model` | `model`、`init`、`mitodoke.yaml` の検証、独自の定義、区分・導出表・言語・置き場所の設定 |
| `authoring` | `new`、`index` |
| `inspection` | `check`、`gap`、`matrix`、テスト資産の一覧の読み込み、検査の強さの設定 |
| `freshness` | `fresh`、`verify` |
| `result-handoff` | `export`、用語と避ける綴りの JSON、outturn への適合 |
| `distribution` | Nix flake での配布、sara の CLI を一緒に配ること、名前の導出 |

### テストのレベル

テストのレベルは次の 2 つである。

- 単体のテスト: crate の中のモジュールを確かめ、`cargo test` で流す
- 受け入れテスト: ビルドしたバイナリを fixture のリポジトリに対して実行する。e2e テストは
  受け入れテストと同じレベルを指す

別のモデルを使うテストはプロセスを分ける。受け入れテストはバイナリを実行するので、もともと
プロセスが分かれる。単体のテストでは、モデルを install するテストをモデルごとに別のテスト
バイナリに置く。

`verify` と、`new` が設定のコマンドから人の識別子を取る場合の受け入れテストは、疑似端末で流す。

### 受け入れテストの fixture

受け入れテストは fixture だけに依る。fixture は自分の `mitodoke.yaml` を持ち、実物の
`docs/model.yaml` を重ねない。実物の文書は mitodoke 自身の文書に対する `mitodoke check` で
別に確かめる。

### 写した契約テストから引き継ぐ範囲

写した契約テストの期待 141 行のうち、110 行を受け入れテストに引き継ぐ。行数は別の製品から写した契約テスト
（`dev/tests/*.sh` の 11 本）の期待を、下位のシナリオの単位で数えたものである。内訳は次の表のとおりで
ある。

| 契約テストの期待の種類 | 行数 | 扱い |
| --- | --- | --- |
| `sara-new`・`sara-gap`・`sara-fresh` の、exit code、JSON のキー、`id:` と `file:` の 2 行で確かめる期待 | 52 | 引き継ぐ。JSON のキーは `result.info` の下で確かめる |
| `sara-new` が書いたファイルの中身を確かめる期待 | 7 | 引き継ぐ |
| `okf-index` が生成した `index.md` の中身を確かめる期待と、`--check` の exit code | 17 | 引き継ぐ |
| `sara-verify` の期待 | 26 | 引き継ぐ。疑似端末で流し、ビューアとエディタは設定のコマンドをテスト用のコマンドに差し替える |
| `okf-frontmatter`・`link-text`・`test-doc-map` の、違反を持つ fixture で判定を確かめる期待 | 8 | 引き継ぐ。`check` の契約ごとの受け入れテストにする |
| text 出力の見出しと行の形式だけを確かめる期待 | 9 | 引き継がない |
| 偽の sara に差し替える期待 | 6 | 引き継がない |
| 実物の `docs/` を読んで違反が 0 件であることを確かめる期待 | 15 | 引き継がない。mitodoke 自身の文書に対する `mitodoke check` が代わりに確かめる |
| 実際の現在時刻に依る期待 | 1 | 引き継がない |

item が 0 件のグラフで exit code 0 になることは、空のグラフの fixture で新しく確かめる。

`term-avoid.sh` は受け入れテストにせず、mitodoke 自身のリポジトリの検査として残す。

### 対象外の品質特性

mitodoke 自身が risk を起こさない品質特性は `safety` だけである。`dev/tests/quality-characteristic-exclusions.tsv`
に次の理由を書く。

> mitodoke は手元と CI で文書を読み書きする CLI で、人の生命、健康、財産、環境に害を及ぼす動作を持たない。

### 手順書とテストチャーターの置き場所

mitodoke 自身の手順書は `tests/manual/procedures/` に、テストチャーターは `tests/manual/charters/` に
置く。テスト資産の一覧には、[テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](../requirements/test-asset-inventory-sources.md)
に沿って、列挙のコマンドで載せる。2 つのディレクトリは最初のファイルを置くときに作る。

## 出典

根拠の決定は次の ADR が持つ。

- [mitodoke 自身のテストのレベルを、単体のテストと受け入れテストの 2 つにする](../adr/two-test-levels-unit-and-acceptance.md)
- [mitodoke 自身のテストの区分を、CLI の子の epic の範囲に 1 つずつ合わせる](../adr/own-test-categories-follow-cli-epics.md)
- [受け入れテストは fixture だけに依り、実物のモデルを重ねない](../adr/acceptance-tests-depend-on-fixtures-only.md)
- [写した契約テストの期待 141 行のうち 110 行を、受け入れテストに引き継ぐ](../adr/acceptance-scope-inherited-from-copied-contract-tests.md)
- [mitodoke 自身が対象外にする品質特性を safety だけにする](../adr/safety-excluded-from-quality-characteristics.md)

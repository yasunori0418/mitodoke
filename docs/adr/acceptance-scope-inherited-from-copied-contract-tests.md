---
id: "ADR-5b4f881c-da4c-46a2-8f04-fe2ab1c80753"
type: adr
name: "写した契約テストの期待 141 行のうち 110 行を、受け入れテストに引き継ぐ"
description: "写した契約テストの期待 141 行のうち、書いたファイルの中身・index.md の中身・verify の対話を含む 110 行を受け入れテストに引き継いで、空のグラフで exit code 0 になることを新しく確かめ、term-avoid.sh は受け入れテストにせずリポジトリの検査として残す。"
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
  at: "2026-11-25T00:22:12+09:00"
---
# 写した契約テストの期待 141 行のうち 110 行を、受け入れテストに引き継ぐ

- ステータス: stable
- 日付: 2026-11-24
- 関連: [写した契約テストを CLI の受け入れテストにする](contract-tests-as-cli-acceptance-tests.md), [受け入れテストは fixture だけに依り、実物のモデルを重ねない](acceptance-tests-depend-on-fixtures-only.md), [mitodoke 自身のテストのレベルを、単体のテストと受け入れテストの 2 つにする](two-test-levels-unit-and-acceptance.md), GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

[写した契約テストを CLI の受け入れテストにする](contract-tests-as-cli-acceptance-tests.md) で、写した
契約テストを CLI の受け入れテストにすると決めてある。揃えるのは JSON のキー、exit code、起票で出す `id:`
と `file:` の 2 行で、text 出力の見出しと行の形式は揃えず、偽の sara に差し替える節は外す。

別の製品から写した契約テスト（`dev/tests/*.sh` の 11 本）の期待を、#75 の grilling で下位のシナリオの単位で
棚卸しすると、141 行ある。揃える 3 つで確かめられない期待（書いたファイルの中身、
`index.md` の中身、`verify` の対話など）を引き継ぐかは決まっていなかった。避ける綴りを確かめる
`term-avoid.sh` を受け入れテストとして残すかも決まっていなかった。

## 決定

写した契約テストの期待 141 行のうち 110 行を、受け入れテストに引き継ぐ。内訳は次の表のとおりである。

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

## 根拠

item が 0 件のグラフで exit code 0 になることは、今は偽の sara の節だけが確かめている。偽の sara の節を
外すと確かめる場所が無くなるので、空のグラフの fixture で新しく確かめる。

実物の `docs/` を読んで違反が 0 件であることは、mitodoke 自身の文書に対する `mitodoke check` が
代わりに確かめる。

避ける綴りの検査を CLI は内蔵しないので、`term-avoid.sh` を受け入れテストにしても、確かめる対象は JSON の
出力だけになる。

## 棄却した代替案

### 52 行だけを引き継ぐ

揃える 3 つ（JSON のキー、exit code、`id:` と `file:` の 2 行）で確かめられる 52 行だけを引き継ぐ
案。52 行は 141 行のうち `sara-new`・`sara-gap`・`sara-fresh` の 3 本が持つ期待で、揃える 3 つのどれかで
確かめるものである。書いたファイルの中身、`index.md` の中身、`verify` の対話は、子の epic が詳細設計で決める。この案では、
今の契約テストが確かめているこれらの期待が、子の epic の設計しだいで確かめられなくなる。

### term-avoid.sh を受け入れテストに残す

`term-avoid.sh` を受け入れテストに残す案。避ける綴りの検査を CLI は内蔵しないので、受け入れテストが
確かめる対象は JSON の出力だけになる。

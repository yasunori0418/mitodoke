---
id: "ADR-9359932e-a2bd-4ea7-b039-aae160063443"
type: adr
name: "risk に ISO/IEC 25010:2023 の品質特性を 1 つ必須で持たせる"
description: "risk に ISO/IEC 25010:2023 の 9 つの品質特性で固定した enum の quality_characteristic を必須で持たせ、リスクを持たない特性を、対象外の宣言を除いて報告する。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定"
justifies:
  - "QA-3952eb05-440f-4287-925c-62dd136b6b89"
  - "REQ-05cc6e6a-6440-429f-8447-16bd7b192d9c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:31:16+09:00"
---
# risk に ISO/IEC 25010:2023 の品質特性を 1 つ必須で持たせる

- ステータス: stable
- 日付: 2026-11-22
- 関連: GitHub Issue #80, `docs/model.yaml`, `dev/scripts/sara-new.sh`
- 起点: issue #80 の grilling（2026-11-22）で確定

## 背景

risk は requirement や design を脅かす懸念を書くが、どの品質の側面を脅かすかを持たない。そのため、
ある品質特性についてリスクの検討が及んでいないことを、グラフから読み取れない。

参照する ISTQB CTFL v4.0.1 は、品質特性に ISO/IEC 25010 の 2023 年版を引く。2023 年版の製品品質
モデルは 9 つの品質特性を持つ。

## 決定

- risk に `quality_characteristic` を必須で足す。値は ISO/IEC 25010:2023 の 9 つの品質特性で固定した
  enum とし、risk 1 本に 1 つとする。2 つの特性にまたがるリスクは risk を分ける
- 日本語名はこの 9 つに限り JIS X 25010（2023 年版に対応する改正）から採る
- 有効な risk（`status` が `deprecated` でないもの。`draft` を含む）を 1 本も持たない特性を報告する。製品が対象外にする特性は理由付きで宣言し、報告から
  外す。CLI の設定ファイルができるまでは、`dev/tests/quality-characteristic-exclusions.tsv`（特性と
  理由の 2 列）に書く
- `sara-new` は、risk の起票で `quality_characteristic` の指定が無ければ拒否する

## 根拠

品質特性で risk を分ければ、どの特性にリスクの検討が及んでいないかを機械的に見つけられる。値を
固定した enum にするのは、特性の名前の揺れで報告が割れないようにするためである。1 本に 1 つに
すると、特性ごとの数え方が一つに決まる。

対象外の宣言に理由を求めるのは、検討して外した特性と、検討していない特性を区別するためである。
`sara init` は enum の指定が無いと先頭の値を黙って入れるので、起票の時点で拒否しなければ、検討して
いない特性が記録に紛れ込む。

## 棄却した代替案

### 1 本の risk に複数の特性を持たせる

特性ごとの数え方が曖昧になり、その risk を潰す test_condition がどの特性を確かめるのかも読み取れなくなる。

### ISO/IEC 25010 の 2011 年版の 8 特性を使う

参照する ISTQB CTFL v4.0.1 が引くのは 2023 年版である。2011 年版を使うと、安全性を扱えない。

### quality_characteristic を任意にする

付け忘れた risk がどの特性にも数えられないまま残る。

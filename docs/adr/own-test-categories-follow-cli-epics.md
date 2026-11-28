---
id: "ADR-54088208-d015-43d5-be21-fb638f5bace3"
type: adr
name: "mitodoke 自身のテストの区分を、CLI の子の epic の範囲に 1 つずつ合わせる"
description: "mitodoke 自身のテストの区分を foundation・config-model・authoring・inspection・freshness・result-handoff・distribution の 7 つにし、CLI を作る #6 の子の epic A〜G の範囲に 1 つずつ合わせる。"
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
  at: "2026-11-25T00:04:47+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:35:45+09:00"
---
# mitodoke 自身のテストの区分を、CLI の子の epic の範囲に 1 つずつ合わせる

- ステータス: stable
- 日付: 2026-11-24
- 関連: [テストの区分を製品の概念にし、中身は設定で決める](test-categories-configured-per-product.md), [risk の節はテストの区分と同じ語彙にする](risk-sections-follow-test-categories.md), GitHub Issue #6, GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

テストの区分は製品の概念で、中身は設定で決める。risk の `section` はテストの区分と同じ語彙にする。

mitodoke 自身の区分は文書を管理する script と一緒に写した値のままだった。risk を起こすときは、区分から
`section` を選ぶ。CLI の実装の前に、mitodoke 自身の区分を決める必要があった。

## 決定

mitodoke 自身のテストの区分を次の 7 つにする。並び順もこのとおりにする。CLI を作る #6 の子の epic
A〜G の範囲に 1 つずつ合わせる。

| 区分 | 範囲 | 対応する #6 の子の epic |
| --- | --- | --- |
| `foundation` | sara-core を呼ぶこと、読み込みを 1 つにまとめること、設定ファイルの探し方、エンベロープとコードの共通の形、時刻の扱い、端末からの実行の判定 | A 基盤 |
| `config-model` | `model`、`init`、`mitodoke.yaml` の検証、独自の定義、区分・導出表・言語・置き場所の設定 | B 設定とモデルの生成 |
| `authoring` | `new`、`index` | C 起票と一覧の生成 |
| `inspection` | `check`、`gap`、`matrix`、テスト資産の一覧の読み込み、検査の強さの設定 | D 検査 |
| `freshness` | `fresh`、`verify` | E 再確認と人の確認 |
| `result-handoff` | `export`、用語と避ける綴りの JSON、outturn への適合 | F 結果の受け渡し |
| `distribution` | Nix flake での配布、sara の CLI を一緒に配ること、名前の導出 | G 置き換えと配布 |

## 根拠

テスト資産は、テストコードを書く子の epic が作る。区分を子の epic の範囲に合わせれば、テスト資産の
置き場所は作った epic で 1 つに決まる。

今ある要件 41 本はどれもこの 7 つのどれかに入る。risk を起こすときは、要件が属する範囲から
`section` を選べる。

`authoring`・`inspection`・`freshness`・`distribution` は `adr` や `ubiquitous_term` の `section` に
すでにある語である。

## 棄却した代替案

### 要件の section の 6 値をそのまま使う

要件の `section` の 6 値（`product-scope`・`model-config`・`inspection`・`commands`・`json-output`・
`distribution`）を区分にする案。risk の `section` は脅かす要件の `section` と同じ値になる。ただし
`commands` には `new`・`verify`・`init`・テスト資産の一覧が入り、機能の単位にならない。`product-scope`
はテストの対象の名前にならない。

### サブコマンドごとに区分を立てる

`new`・`gap`・`fresh`・`index`・`matrix`・`model`・`verify`・`export`・`check`・`init` と、共通の部分に
区分を立てる案。区分が 11 になり、読み込みやエンベロープのような共通の部分のテストの置き場所が、
サブコマンドの区分と重なる。

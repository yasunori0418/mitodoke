---
id: "ADR-4fcaca23-95a6-483f-a62b-e59dca0857d0"
type: adr
name: "モデルを読めなければ exit 2 で終え、組み込みの型へ戻らない"
description: "モデルを読めないときと install が失敗したときは、グラフを読むサブコマンドと check が exit 2 で終えて組み込みの型へ戻らず、item が 0 件であること自体は誤りにも該当にもしない。"
section: inspection
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:24:39+09:00"
---
# モデルを読めなければ exit 2 で終え、組み込みの型へ戻らない

- ステータス: stable
- 日付: 2026-11-23
- 関連: GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

sara-core は、モデル（model.yaml）を読めないとき、組み込みの型に戻って処理を続ける。組み込みの型に
戻ると、適用先の製品のモデルとは違う型でグラフを読み、誤った結果を出す。issue #73 の調査では、モデル
（active schema）を 1 つのプロセスで 1 度しか install できないことも分かった。

`init` は model.yaml を作らず、`model` が設定から model.yaml を生成する。`init` の直後は item が 0 件
である。

## 決定

モデルを読めないときと、モデルの install が失敗したときは、ドキュメントグラフを読み込むサブコマンドと
`check` が exit 2 で終え、組み込みの型へ戻らない。`init` と `model` はグラフを読まないので、対象に
しない。

item が 0 件であること自体は、誤りにも該当にもしない。item が 0 件の実行は、ほかに失敗の指摘が無ければ
exit 0 で終える。

## 根拠

モデルを読めないまま組み込みの型で続けると、結果が適用先のモデルに合っているかを、結果を読む側が
見分けられない。exit 2 で止めれば、入力の誤りとして扱える。

`init` と `model` を対象にすると、model.yaml を生成する前にこれらが動かなくなる。

sara の CLI で item を 1 件置く必要があったのは、0 件だとモデルの誤りに気づけなかったためである。
mitodoke はモデルの読み込みの失敗を自分で誤りにするので、0 件を誤りにする理由が無い。0 件を誤りに
すると、`init` の直後に最初の item を起こす `new` も、導入した直後の CI の `check` も失敗する。

## 棄却した代替案

### item が 0 件のときも、どのサブコマンドも exit 2 で終える

`init` の直後は item が 0 件なので、最初の item を起こす `new` も、`model` も、導入した直後の CI の
`check` も失敗する。

### グラフを読むサブコマンド（`check`・`gap`・`fresh`・`matrix`・`export`）だけ、0 件を exit 2 にする

走査先の設定を誤って 1 件も読めていないことに気づけるが、導入した直後の CI が失敗する。

### `init` と `model` も含めて、どのサブコマンドも exit 2 で終える

`init` は model.yaml を作らず、`model` が model.yaml を生成するので、この 2 つが動かなくなる。

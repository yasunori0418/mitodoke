---
id: "ADR-325bf792-a25d-4b71-8258-ae2713c01549"
type: adr
name: "端末からの実行は stdin と stdout の両方が端末であることで判定する"
description: "端末からの実行を stdin と stdout の両方が端末であることで判定し、判定を 1 か所に置いて verify と new で同じものを使い、判定を外す環境変数は製品に持たない。"
section: verification
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
  - "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
references:
  - "ADR-83279925-6de1-44cd-a4bc-6923b0ed900b"
  - "ADR-118fc416-3137-43b9-ab5b-49899dd4b2dc"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:50:33+09:00"
---
# 端末からの実行は stdin と stdout の両方が端末であることで判定する

- ステータス: stable
- 日付: 2026-11-23
- 関連: [generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする](generated-by-from-env-or-flag.md), [verify は、端末で人が確認を入力したときだけ確認の記録を書く](verify-records-human-only-from-terminal.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

`verify` は端末からの実行に限って人の確認を書き、`new` は `generated.by` が与えられないとき、端末からの
実行に限って人の識別子を書く。要件は「エージェントや CI のような端末の無い実行」と例で示すだけで、
「端末からの実行」をどう判定するかを定めていなかった。

写した `sara-verify` は stdin と stdout の両方が端末であるかを見ている。テストのために、この判定を外す
環境変数 `SARA_VERIFY_TTY` も持つ。

## 決定

「端末からの実行」は、stdin と stdout の両方が端末であることで判定する。判定は 1 か所に置き、`verify` と
`new` で同じものを使う。判定を外す環境変数は、製品に持たない。

## 根拠

`verify` の対話は、人が stdin から入力し、stdout で表示を読むので、両方が端末でないと成り立たない。
判定を 1 か所に置けば、`verify` と `new` で「人が端末にいる」の意味が食い違わない。

判定を外す環境変数を製品が持つと、エージェントがそれを設定して、人の確認や人の識別子を書けてしまう。
受け入れテストは、環境変数ではなく疑似端末で流せる。

## 棄却した代替案

### stdin だけを見る

`mitodoke new ... | tee log` のように出力をパイプへ流す使い方を許せるが、`verify` の対話は stdout が
端末でないと成り立たない。

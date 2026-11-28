---
id: "ADR-4de11190-40c0-442d-890b-ed92f3c786b9"
type: adr
name: "サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる"
description: "mitodoke のすべてのサブコマンドの --json を outturn の結果エンベロープにし、§8 の standalone まで含めて適合させ、既定の text 出力は変えない。"
section: json-output
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q43）で確定"
justifies:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
references:
  - "ADR-f3d7ea3d-2959-41ec-8170-9678815196d0"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:13+09:00"
---
# サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる

- ステータス: stable
- 日付: 2026-11-17
- 関連: [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](single-cli-with-subcommands.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q43）で確定

## 背景

mitodoke は、検査と検出の結果を CI やほかのツールへ渡すために、サブコマンドの `--json` で
JSON を出す。それまでの決定では、報告のサブコマンドの JSON のキーを、写した script の JSON に
揃えることにしていた。

outturn は、stdout に 1 つの JSON 文書（結果エンベロープ）を出す規格である。トップレベルに
`status`・`errors`・`warnings`・`results` などを持ち、主体（subject）ごとの結果の中に item の
配列を持つ。ツール固有の値は `info` の下だけに置く。exit code は、0 を `success` に、0 以外を
`error` に結ぶ。適合の条件は、schema の検証、schema で表せない規則のリント、id のテストベクタの
全件成功、§8 の `standalone`（入力は stdin の JSON か明示した引数だけで、設定を暗黙に探さない）の
4 つである。outturn の状態は draft で、Rust の実装は無い。

mitodoke の `--json` の出力を、この規格にどこまで合わせるかを決める必要があった。

## 決定

mitodoke のすべてのサブコマンドの `--json` を outturn のエンベロープにし、§8 の `standalone`
まで含めて適合させる。`--json` は選んだときだけ出す第 2 の契約とし、既定の text 出力は変えない。

これに伴い、報告のサブコマンドの JSON のキーは `result.info` の下で揃え、該当あり（exit code 1）は
`failed` の item で表す。`export` が出す sara の形は item の `info` の下に置く。スキルが JSON を
読む箇所は、サブコマンドの名前に加えて、読むパスも直す。outturn の Rust 対応は、必要なら outturn
の側で用意する。

## 根拠

outturn は、単一の役割のツールを共通の結果の形で組み合わせるための規格で、利用者が示した
UNIX 哲学の方針と合う。

JSON のキーの置き場所は変わるが、mitodoke はまだ実装前である。スキルの書き換えは、サブコマンドの
名前の変更と一緒に済ませられる。

## 棄却した代替案

### エンベロープの形だけを合わせ、standalone は求めない

schema・リント・id の導出だけを合わせる案。適合の条件のうち `standalone` を満たさないので、
outturn に適合したツールとは言えない。

### outturn に合わせない

報告のサブコマンドの JSON のキーを写した script に揃え、`export` の形もそのまま出す案。
mitodoke の JSON だけが、outturn に適合したほかのツールと違う形になる。

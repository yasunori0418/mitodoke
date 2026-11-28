---
id: "ADR-2388688a-0bb5-42c3-8e71-76e6e733cf2c"
type: adr
name: "写した契約テストを CLI の受け入れテストにする"
description: "写した契約テストを mitodoke の CLI の受け入れテストにし、outturn の result.info の下の JSON のキー・exit code・起票の id: と file: の 2 行を揃え、text 出力の見出しと行の形式は揃えない。"
section: json-output
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q19）で確定"
justifies:
  - "TP-cf0c38d2-8929-4a69-adef-8d2dc63115df"
references:
  - "ADR-7bef3ffc-d2db-4da1-98d0-3678f57c3ea6"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:24:10+09:00"
---
# 写した契約テストを CLI の受け入れテストにする

- ステータス: stable
- 日付: 2026-11-17
- 関連: [サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける](subcommands-split-by-function.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q19）で確定

## 背景

mitodoke のリポジトリには、文書を管理する shell script と、その契約テストを写した。契約テストは、
結果を `ok   - <説明>` か `FAIL - <説明>` の行で出し、失敗の有無を exit code にする。報告の script
（`sara-gap` と `sara-fresh`）は `--json` で JSON を出し、exit code は 0（該当なし）・1（該当あり）・
2（`sara check` の失敗や引数の誤り）の 3 つである。スキルは、起票の script（`sara-new`）が出す
`id:` と `file:` の 2 行を前提にしている。

報告と起票の script の契約テストには、環境変数で偽の sara に差し替え、JSON の形の異常で exit
code 2 になることや、`sara init` の exit code 3 がそのまま返ることを確かめる節がある。sara-core を
組み込む CLI には差し替える sara の CLI が無いので、これらの節はそのままでは使えない。

CLI ができたときに、写した契約テストを CLI の受け入れテストにも使うかを決める必要があった。

## 決定

写した契約テストを CLI の受け入れテストにする。CLI のサブコマンドを、写した fixture と同じ期待で
確かめる。

揃えるのは、JSON のキー、exit code（0 は該当なし、1 は該当あり、2 は入力や環境の誤り）、起票で
出す `id:` と `file:` の 2 行である。JSON のキーは outturn のエンベロープの `result.info` の下で
揃え、該当あり（exit code 1）は `failed` の item で表す。text 出力の見出しと行の形式は揃えない。
偽の sara に差し替える節は外す。

単体の報告のサブコマンドが該当ありで exit code 1 を返すことと、`check` が強さの設定に従って失敗か
報告かを決めることは別に扱い、受け入れテストは前者を確かめる。

## 根拠

script と CLI を同じテストで確かめておけば、写した script を CLI に置き換えるときに、同じ入力で
同じ判定になると示せる。

JSON のキーと `id:`・`file:` の 2 行を揃えるのは、スキルの手順を書き換えずに CLI へ移るため
だった。`--json` を outturn のエンベロープにしたので、キーは `result.info` の下で揃えることに
なり、スキルが JSON を読む箇所はパスを直す。

## 棄却した代替案

### 受け入れテストにしない

CLI のテストは Rust で新しく書き、写した契約テストは script を置き換えるときに捨てる案。置き換えた
あとに、script と CLI の判定が一致しているかを確かめる手段が無い。

### text 出力の見出しと行の形式まで揃える

受け入れテストにし、text 出力の見出し（日本語の節の名前）と行の形式まで揃える案。text 出力の
見出しや並びを変えるたびに、テストも直すことになる。

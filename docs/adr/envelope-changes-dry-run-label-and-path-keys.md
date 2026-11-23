---
id: "ADR-2b4bb97f-93d4-4e99-b715-552d32a99c43"
type: adr
name: "changes・dryRun・label はファイルを書くかで分け、ID の無い item はパスで表す"
description: "ファイルを書くサブコマンドは書いたファイルを item と changes[] に並べて dryRun を false にし、--check と読むだけのサブコマンドは dryRun を true にし、label はすべての item に付け、文書の ID を持たない item の key と label は設定ファイルのあるディレクトリからの相対パスにする。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
references:
  - "ADR-4de11190-40c0-442d-890b-ed92f3c786b9"
  - "ADR-6f2020c5-dc77-44c6-8471-1bd2f72f1f48"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:55:25+09:00"
---
# changes・dryRun・label はファイルを書くかで分け、ID の無い item はパスで表す

- ステータス: stable
- 日付: 2026-11-23
- 関連: [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](json-output-conforms-to-outturn.md), [check・gap・fresh の item を契約 × 文書の単位にする](result-items-per-contract-and-document.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

outturn は `dryRun` を必須にし、`changes[]` を任意にしている。`changes[]` の要素は `add`・`remove`・
`modify` のどれかと、item の `id` を持つ。副作用の無い check では、`dryRun` を `true` にすることを勧めて
いる。outturn は、item の `key` に計算機ごとに変わる値を入れることを禁じている。

mitodoke には、ファイルを書くサブコマンドと、読むだけのサブコマンドがある。item の `key` は文書の ID と
していたが、読み飛ばされたファイルと書いたファイルを表す item は、文書の ID を持たないことがある。

## 決定

- ファイルを書くサブコマンド（`new`・`init`・`index`・`model`・`verify`）は、書いたファイル 1 つを item
  1 つにし、`changes[]` に `add` か `modify` を並べ、`dryRun` を `false` にする
- `index` と `model` の `--check` は、`dryRun` を `true` にし、差分のあるファイルを `failed` の item に
  して、`changes[]` に書くはずだった変更を並べ、exit 1 で終える
- 読むだけのサブコマンド（`check`・`gap`・`fresh`・`matrix`・`export`）は、`dryRun` を `true` にし、
  `changes[]` を出さない
- `label` はすべての item に付ける。文書を表す item では、文書の `name` にする
- 文書の ID を持たない item（読み飛ばされたファイル、書いたファイル）の `key` と `label` は、設定ファイル
  のあるディレクトリからの相対パスにする

## 根拠

書いたファイルを item と `changes[]` に並べれば、結果を読む側が、どのファイルが変わったかを outturn の
語彙で読める。`--check` は書かずに差分を確かめる実行なので、予行として `dryRun` を `true` にし、書くはず
だった変更を見せる。読むだけのサブコマンドは副作用が無いので、outturn の勧めに合わせて `dryRun` を
`true` にする。

`label` を文書の `name` にすれば、text 出力と同じ見出しで item を読める。

設定ファイルのあるディレクトリからの相対パスは、実行する場所や計算機によらず同じ値になり、outturn の
`key` の制約を満たす。

## 棄却した代替案

### 読むだけのサブコマンドの `dryRun` を `false` にする

「予行ではなく本番の実行である」という読みには合うが、outturn の check の勧めと逆になる。

### ファイルを表す item の `label` を、作業ディレクトリからの相対パスにする

作業ディレクトリからの相対パスは、実行する場所で変わる。

### 文書の ID を持たない item の `key` を、リポジトリのルートからの相対パスにする

場所によらず同じ値になるが、git の管理下に無い場所では決められない。

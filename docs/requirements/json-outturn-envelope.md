---
id: "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
type: requirement
name: "サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない"
description: "mitodoke のすべてのサブコマンドは --json を選んだときだけ outturn に適合する結果エンベロープを出し、既定の text 出力は変えない。"
specification: |
  Every subcommand of mitodoke SHALL, when invoked with --json, write a result envelope that
  conforms to the outturn specification, including the standalone requirement of its section 8.
  The --json output SHALL be a second contract emitted only when --json is selected, and
  selecting it SHALL NOT change the default text output. A finding that makes a subcommand exit
  with code 1 SHALL be represented in the envelope as an item whose status is failed.
  `results[]` SHALL always have exactly one element, and its `subject.name` SHALL be the fixed
  string `documents`. The subcommands that write files (new, init, index, model and verify) SHALL
  represent each written file as one item, SHALL list an `add` or a `modify` for it in
  `changes[]`, and SHALL set `dryRun` to false. The --check option of index and model SHALL set
  `dryRun` to true, SHALL represent each file that differs as an item whose status is failed,
  SHALL list in `changes[]` the changes that it would have written, and SHALL end with exit code
  1 when a file differs. The subcommands that only read (check, gap, fresh, matrix and export) SHALL set `dryRun` to
  true and SHALL NOT emit `changes[]`. Every item SHALL have a `label`, and the `label` of an item
  that represents a document SHALL be the `name` of the document. The `key` and the `label` of an
  item that has no document ID (a skipped file or a written file) SHALL be the path relative to
  the directory that contains the configuration file.
specification_ja: |
  mitodoke のすべてのサブコマンドは、--json を指定されたとき、outturn の仕様に、§8 の
  standalone の要件まで含めて適合する結果エンベロープを出さなければならない。--json の出力は、
  --json を選んだときだけ出す第 2 の契約でなければならず、既定の text 出力を変えてはならない。
  サブコマンドを exit code 1 で終わらせる該当は、エンベロープの中で status が failed の item
  として表さなければならない。
  `results[]` の要素は常に 1 つでなければならず、その `subject.name` は固定の文字列 `documents` で
  なければならない。ファイルを書くサブコマンド（new・init・index・model・verify）は、書いたファイル
  1 つを item 1 つで表し、`changes[]` に `add` か `modify` を並べ、`dryRun` を false にしなければ
  ならない。index と model の --check は、`dryRun` を true にし、差分のあるファイルを status が failed
  の item で表し、`changes[]` に書くはずだった変更を並べて、差分があれば exit code 1 で終わらなければならない。
  読むだけのサブコマンド（check・gap・fresh・matrix・export）は、`dryRun` を true にしなければならず、
  `changes[]` を出してはならない。すべての item は `label` を持たなければならず、文書を表す item の
  `label` は文書の `name` でなければならない。文書の ID を持たない item（読み飛ばされたファイル、
  書いたファイル）の `key` と `label` は、設定ファイルのあるディレクトリからの相対パスでなければ
  ならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:15:54+09:00"
---
# サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない

## 仕様

mitodoke のサブコマンドは、`--json` を指定されたときに、outturn の結果エンベロープを stdout に
出す。適合は、schema の検証・リント・id のテストベクタに加えて、§8 の `standalone` まで含める。
`standalone` の満たし方は
[設定ファイルは作業ディレクトリから読み、作業ディレクトリを workingDirectory に、設定ファイルのパスと暗黙の入力を info に記録する](config-discovery-and-record.md)
が定める。

`--json` の出力は、利用者が選んだときだけ出す第 2 の契約である。`--json` を付けない実行の
text 出力は、この要求によって変わらない。

outturn は exit code の 0 を `success` に、0 以外を `error` に結ぶ。サブコマンドが該当ありで
exit code 1 を返すときは、その該当を `status` が `failed` の item としてエンベロープに表す。

エンベロープの形は、次のように決める。

- `results[]` の要素は常に 1 つにし、`subject.name` は固定の文字列 `documents` にする
- ファイルを書くサブコマンド（`new`・`init`・`index`・`model`・`verify`）は、書いたファイル 1 つを item
  1 つにし、`changes[]` に `add` か `modify` を並べ、`dryRun` を `false` にする
- `index` と `model` の `--check` は、`dryRun` を `true` にし、差分のあるファイルを `failed` の item に
  して、`changes[]` に書くはずだった変更を並べ、差分があれば exit code 1 で終わる
- 読むだけのサブコマンド（`check`・`gap`・`fresh`・`matrix`・`export`）は、`dryRun` を `true` にし、
  `changes[]` を出さない
- `label` はすべての item に付ける。文書を表す item では、文書の `name` にする
- 文書の ID を持たない item（読み飛ばされたファイル、書いたファイル）の `key` と `label` は、設定ファイル
  のあるディレクトリからの相対パスにする

## 出典

根拠の決定は次の ADR が持つ。

- [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](../adr/json-output-conforms-to-outturn.md)
- [エンベロープの subject は固定の documents 1 つにする](../adr/envelope-subject-fixed-to-documents.md)
- [changes・dryRun・label はファイルを書くかで分け、ID の無い item はパスで表す](../adr/envelope-changes-dry-run-label-and-path-keys.md)

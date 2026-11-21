---
id: "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
type: requirement
name: "サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない"
description: "mitodoke のすべてのサブコマンドは --json を選んだときだけ outturn に適合する結果エンベロープを出し、既定の text 出力は変えない。"
specification: |
  Every subcommand of mitodoke SHALL, when invoked with --json, write a result envelope that
  conforms to the outturn specification, including the standalone requirement of its section 8 in
  the form that [設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する](config-discovery-and-record.md)
  specifies.
  The --json output SHALL be a second contract emitted only when --json is selected, and
  selecting it SHALL NOT change the default text output. A finding that makes a subcommand exit
  with code 1 SHALL be represented in the envelope as an item whose status is failed.
specification_ja: |
  mitodoke のすべてのサブコマンドは、--json を指定されたとき、outturn の仕様に、§8 の
  standalone の要件まで
  [設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する](config-discovery-and-record.md)
  の形で含めて適合する結果エンベロープを出さなければならない。--json の出力は、
  --json を選んだときだけ出す第 2 の契約でなければならず、既定の text 出力を変えてはならない。
  サブコマンドを exit code 1 で終わらせる該当は、エンベロープの中で status が failed の item
  として表さなければならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:45:19+09:00"
---
# サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない

## 仕様

mitodoke のサブコマンドは、`--json` を指定されたときに、outturn の結果エンベロープを stdout に
出す。適合は、schema の検証・リント・id のテストベクタに加えて、§8 の `standalone` まで含める。
`standalone` は、設定ファイルを作業ディレクトリから読み、読んだパスを記録する形で満たす（[設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する](config-discovery-and-record.md)）。
この形が §8 の文言どおりと言えるかは、outturn #66 の結論で決まる。

`--json` の出力は、利用者が選んだときだけ出す第 2 の契約である。`--json` を付けない実行の
text 出力は、この要求によって変わらない。

outturn は exit code の 0 を `success` に、0 以外を `error` に結ぶ。サブコマンドが該当ありで
exit code 1 を返すときは、その該当を `status` が `failed` の item としてエンベロープに表す。

## 出典

根拠の決定は次の ADR が持つ。

- [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](../adr/json-output-conforms-to-outturn.md)

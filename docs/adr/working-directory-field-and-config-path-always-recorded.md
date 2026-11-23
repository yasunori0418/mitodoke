---
id: "ADR-79c6a5d6-ee56-4516-a61b-98c611da9082"
type: adr
name: "作業ディレクトリは workingDirectory に出し、設定ファイルのパスは常に info に記録する"
description: "`--config` を省いたときは作業ディレクトリの設定ファイルだけを読み、作業ディレクトリはエンベロープの `workingDirectory` に出し、読んだ設定ファイルの絶対パスと、環境変数と設定のコマンドから取った値は常にトップレベルの `info` に記録する。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定。設定ファイルは作業ディレクトリのものだけを読み、読んだパスを info に記録する ADR を書き直した"
justifies:
  - "REQ-ecc41a24-b465-4ab9-ba1b-e56dc5f8a17c"
supersedes:
  - "ADR-2b12d667-4e1a-4812-943b-39a7b60fe6ad"
references:
  - "ADR-f2d8d15d-b62b-4a7a-ace0-d3a6fbeab30e"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:56:48+09:00"
---
# 作業ディレクトリは workingDirectory に出し、設定ファイルのパスは常に info に記録する

- ステータス: stable
- 日付: 2026-11-23
- 関連: [設定ファイルは作業ディレクトリのものだけを読み、読んだパスを info に記録する](config-read-from-working-directory-and-recorded.md), [設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする](config-file-mitodoke-yaml.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定。設定ファイルは作業ディレクトリのものだけを読み、読んだパスを info に記録する ADR を書き直した

## 背景

mitodoke の `--json` は、outturn の §8 の `standalone` まで含めて適合させると決めている。mitodoke は
設定ファイルを読み、環境変数も読む。以前は、outturn に作業ディレクトリを表す標準のフィールドが無かった
ので、作業ディレクトリと読んだ設定ファイルのパスを、どちらもトップレベルの `info` に記録すると決めた。

outturn の今の仕様（main の `628a470`、2026-11-18）は、作業ディレクトリを必須のフィールド
`workingDirectory` で出すことと、暗黙の入力の解決結果をトップレベルの `info` に記録することを求めて
いる。入力をすべて引数で与えて実行できることも必須である。

## 決定

- `--config` を省いたときは、作業ディレクトリの設定ファイルを読み、上のディレクトリへは探さない
- 作業ディレクトリは、エンベロープの `workingDirectory` に出し、`info` には書かない
- 読んだ設定ファイルの絶対パスは、`--config` で指したときも省いたときも、トップレベルの `info` に記録する
- 環境変数 `MITODOKE_GENERATED_BY` から取った値と、設定のコマンドから作った人の識別子も、トップレベルの
  `info` に記録する
- `info` のキーは、outturn のフィールドに合わせてキャメルケースにする

## 根拠

作業ディレクトリは outturn の必須のフィールドで出せるので、`info` に重ねて書かない。

読んだ設定ファイルのパスを常に記録すれば、結果を読む側が、`--config` の有無でキーがあるかを場合分け
しなくてよい。環境変数と設定のコマンドから取った値は暗黙の入力なので、outturn の求めに従って記録する。
`--by` と `--config` があるので、入力をすべて引数で与える実行もできる。

上のディレクトリへ探さないのは、作業ディレクトリ 1 つを記録すれば読む場所が決まり、再現の手がかりが
単純になるからである。

## 棄却した代替案

### 設定ファイルのパスを、`--config` を省いて作業ディレクトリから読んだときだけ記録する

outturn が求める最小の範囲には合うが、結果を読む側がキーの有無で場合を分けることになる。

### 設定ファイルを `--config` で必ず受け取り、作業ディレクトリからは探さず、環境変数も読まない

解釈を挟まずに §8 に沿える。作業ディレクトリと読んだ設定ファイルを出力に記録すれば、探す作りでも再現
できるので、探索をやめる理由にならない。

---
id: "ADR-aa3377ef-efc1-496d-aa90-c00139be8f84"
type: adr
name: "CLI を 1 つの crate にし、役割ごとのモジュールに分ける"
description: "CLI を workspace に分けない 1 つの crate にし、sara-core・frontmatter・読み込み・設定・outturn・git・時刻と端末・契約・サブコマンドの役割ごとのモジュールに分け、ライブラリとして公開しない。"
section: product-scope
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
references:
  - "ADR-22a2cfdf-7f6f-4315-9a73-d3067684cf8b"
  - "ADR-7707ddc2-ee32-49a1-9316-918fe860394c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:58:48+09:00"
---
# CLI を 1 つの crate にし、役割ごとのモジュールに分ける

- ステータス: stable
- 日付: 2026-11-23
- 関連: [Rust で書き、sara-core を crate として組み込む](rust-cli-embedding-sara-core.md), [Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る](distributed-by-nix-flake-with-sara-cli.md), [sara-core を使う箇所を 1 つのモジュールに集める](../design/sara-core-confined-to-one-module.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

CLI の実装の前に、機能をまたぐ構造を決めておかないと、子の epic が並列に進んだときに、読み込み方と出力の
形が食い違う。sara-core を使う箇所は 1 つのモジュールに集めると、既存の `design` で決めている。crates.io
への公開は、出力が固まってからにすると決めている。

## 決定

CLI は 1 つの crate にし、役割ごとのモジュールに分ける。workspace に分けず、ライブラリとして公開しない。
モジュールは次のとおりである。名前は実装のときに決める。

- sara-core を呼ぶモジュール。モデルの install、走査、検証、グラフ、起票をここに集める。ほかのモジュールは
  sara-core を直接使わない
- frontmatter を YAML として読み書きするモジュール。OKF のキーと宣言の無いキーを読み、`generated` と
  `verified` を書く。書くときは、変えるキーのほかの行とコメントを残す
- 読み込みを 1 つにまとめるモジュール。上の 2 つを合わせた結果を作り、「有効な item」の判定と読み飛ばしの
  扱いを持つ。サブコマンドは item をこのモジュールからだけ得る
- 設定ファイルを探して読み、検証するモジュール
- outturn のエンベロープを組み立て、コードを持つモジュール。text 出力もここの結果から作る
- git を呼ぶモジュール
- 時刻の読み書きと比較、端末からの実行の判定を持つ、小さな共通のモジュール
- 契約を 1 つずつ持つモジュール。`check` と、単体の `gap` や `fresh` が同じ実装を呼ぶ
- サブコマンドごとのモジュール。引数を読み、上のモジュールを組み合わせるだけにする

## 根拠

使う側が mitodoke の CLI だけなので、crate を分けて公開する API を持つ理由が無い。1 つの crate の中で
モジュールの役割と依存の向きを決めれば、子の epic が同じモジュールを並列に使っても、読み込み方と出力の
形が食い違わない。

契約を 1 つずつ持つモジュールを `check` と単体の `gap` や `fresh` が共有すれば、同じ契約の判定が 2 通りに
ならない。サブコマンドのモジュールを組み合わせるだけにすれば、読み込みと出力の扱いがサブコマンドごとに
分かれない。

## 棄却した代替案

### 検査や読み込みを持つライブラリの crate と、引数を読む CLI の crate に分ける

ほかのツールから Rust のライブラリとして使えるが、crates.io への公開は出力が固まってからと決めているので、
今は公開する API を持つ理由が無い。

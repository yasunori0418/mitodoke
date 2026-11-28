---
id: "ADR-5797f9d8-b199-4abf-909e-9e7ac4579596"
type: adr
name: "mitodoke 自身のテストのレベルを、単体のテストと受け入れテストの 2 つにする"
description: "mitodoke 自身のテストのレベルを、crate の中のモジュールを cargo test で確かめる単体のテストと、ビルドしたバイナリを fixture のリポジトリに対して実行する受け入れテストの 2 つにし、別のモデルを使うテストはプロセスを分け、端末からの実行が要る受け入れテストは疑似端末で流す。"
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
  at: "2026-11-25T00:03:48+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:03:20+09:00"
---
# mitodoke 自身のテストのレベルを、単体のテストと受け入れテストの 2 つにする

- ステータス: stable
- 日付: 2026-11-24
- 関連: [CLI を 1 つの crate にし、役割ごとのモジュールに分ける](single-crate-split-into-role-modules.md), [実行中に呼ぶ外部のプロセスは、git と設定のコマンドだけにする](external-processes-limited-to-git-and-configured-commands.md), [Rust で書き、sara-core を crate として組み込む](rust-cli-embedding-sara-core.md), [モデルを読めなければ exit 2 で終え、組み込みの型へ戻らない](unreadable-model-exits-without-builtin-fallback.md), [端末からの実行は stdin と stdout の両方が端末であることで判定する](terminal-run-judged-by-stdin-and-stdout.md), GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

CLI の実装に入る前に、mitodoke 自身のテストをどのレベルで確かめるかを決める必要があった。

CLI は 1 つの crate で、役割ごとのモジュールに分ける。実行中に呼ぶ外部のプロセスは git と設定の
コマンドだけである。

sara-core のモデルは 1 つのプロセスで 1 度しか install できない。

`verify` は端末からの実行に限って人の確認を書き、`new` は `generated.by` が与えられないとき、端末からの
実行に限って人の識別子を書く。端末からの実行は stdin と stdout の両方が端末であることで判定し、判定を
外す環境変数を製品は持たない。

## 決定

- テストのレベルは単体のテストと受け入れテストの 2 つにする。単体のテストは crate の中のモジュールを
  `cargo test` で確かめる。受け入れテストはビルドしたバイナリを fixture のリポジトリに対して実行する。
  e2e テストは受け入れテストと同じレベルを指す
- 別のモデルを使うテストはプロセスを分ける。単体のテストでは、モデルを install するテストをモデルごとに
  別のテストバイナリに置く
- `verify` と、`new` が設定のコマンドから人の識別子を取る場合の受け入れテストは、疑似端末で流す

## 根拠

CLI は 1 つの crate で、実行中に呼ぶ外部のプロセスは git と設定のコマンドだけである。単体のテストと
受け入れテストの間に、別に確かめる境界が無い。

モデルは 1 つのプロセスで 1 度しか install できないので、別のモデルを使うテストはプロセスを分けて流す。
受け入れテストはバイナリを実行するので、もともとプロセスが分かれる。

判定を外す環境変数を製品は持たないので、端末からの実行が要る受け入れテストは疑似端末で流す。

## 棄却した代替案

### 結合テストのレベルを別に立てる

単体のテストと受け入れテストの間に、結合テストのレベルを置く案。CLI には 2 つのレベルの間で別に
確かめる境界が無い。

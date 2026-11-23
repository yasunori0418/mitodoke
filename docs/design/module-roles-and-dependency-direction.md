---
id: "DSG-93a931af-2ced-40de-8860-6f07c8a816ae"
type: design
name: "CLI のモジュールを役割で分け、依存の向きを決める"
description: "CLI を 1 つの crate の中の役割ごとのモジュールに分け、モジュールの間の依存の向きと、実行中に呼ぶ外部のプロセスを決める"
section: product-scope
status: stable
satisfies:
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:33:43+09:00"
---
# CLI のモジュールを役割で分け、依存の向きを決める

## 設計

CLI は 1 つの crate にし、役割ごとのモジュールに分ける。workspace に分けず、ライブラリとして公開
しない。モジュールの名前は実装のときに決め、ここでは役割と依存の向きだけを決める。

### モジュールの役割

| モジュール | 役割 |
|---|---|
| sara-core を呼ぶモジュール | モデルの install、走査、検証、グラフ、起票を持つ。sara の検証の種類から契約名への割り当ての表も持つ |
| frontmatter を読み書きするモジュール | frontmatter を YAML として読み、OKF のキーと宣言の無いキーを取り出す。`generated` と `verified` を書き、書くときは変えるキーのほかの行とコメントを残す |
| 読み込みを 1 つにまとめるモジュール | 上の 2 つの結果を合わせた 1 つの読み込みの結果を作る。「有効な item」の判定と、読み飛ばしの扱いを持つ |
| 設定のモジュール | 設定ファイルを探して読み、検証する |
| outturn のモジュール | outturn のエンベロープを組み立て、mitodoke のコードを持つ。text 出力もここの結果から作る |
| git のモジュール | git を呼ぶ |
| 共通のモジュール | 時刻の読み書きと比較と、端末からの実行の判定を持つ、小さなモジュール |
| 契約のモジュール | 契約を 1 つずつ持つ |
| サブコマンドのモジュール | サブコマンドごとに 1 つ置き、引数を読んで上のモジュールを組み合わせる |

### 依存の向き

- sara-core を直接使うのは、sara-core を呼ぶモジュールだけである。ほかのモジュールは sara-core を
  使わない。このモジュールに集める理由は
  [sara-core を使う箇所を 1 つのモジュールに集める](sara-core-confined-to-one-module.md) が持つ
- 読み込みを 1 つにまとめるモジュールは、sara-core を呼ぶモジュールと、frontmatter を読み書きする
  モジュールの 2 つを使う
- サブコマンドのモジュールは、item を読み込みを 1 つにまとめるモジュールからだけ得る。sara-core を
  呼ぶモジュールや frontmatter を読み書きするモジュールから、item を直接得ない
- text 出力は、outturn のモジュールが組み立てた結果から作る。サブコマンドのモジュールが text 出力を
  別に組み立てない
- `check` と、単体の `gap` や `fresh` は、契約のモジュールの同じ実装を呼ぶ
- サブコマンドのモジュールは、ほかのモジュールを組み合わせるだけにし、読み込みと出力の扱いを自分で
  持たない

### 実行中に呼ぶ外部のプロセス

mitodoke が実行中に呼ぶ外部のプロセスは、次のものだけである。

- git
- 設定ファイルに書かれたコマンド（人の識別子を取るコマンド、テスト資産を列挙するコマンド、`verify` の
  ビューアとエディタ）

sara は crate として組み込み、sara の CLI は呼ばない。sara の CLI は、組み込む sara-core と同じタグの
ものを flake で一緒に配る。これは、利用者が mitodoke と同じ版の検証を手で回すためで、mitodoke が
実行中に使うためではない。

## 出典

根拠の決定は次の ADR が持つ。

- [CLI を 1 つの crate にし、役割ごとのモジュールに分ける](../adr/single-crate-split-into-role-modules.md)
- [実行中に呼ぶ外部のプロセスは、git と設定のコマンドだけにする](../adr/external-processes-limited-to-git-and-configured-commands.md)
- [Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る](../adr/distributed-by-nix-flake-with-sara-cli.md)
- [sara の検証の種類ごとに契約名を割り当て、kind とコードを契約名から導く](../adr/contract-name-per-sara-validation-kind.md)

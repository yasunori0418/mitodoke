# 設計（`design`）

## 製品の範囲と構成

* [CLI のモジュールを役割で分け、依存の向きを決める](./module-roles-and-dependency-direction.md) - CLI を 1 つの crate の中の役割ごとのモジュールに分け、モジュールの間の依存の向きと、実行中に呼ぶ外部のプロセスを決める
* [sara-core を使う箇所を 1 つのモジュールに集める](./sara-core-confined-to-one-module.md) - CLI は sara-core を crate として組み込み、sara-core を呼ぶ箇所を CLI の中の 1 つのモジュールに集める
* [ドキュメントグラフの読み込みを 1 つの結果にまとめる](./unified-graph-loading.md) - sara-core の読み込みと frontmatter を読む層を合わせた 1 つの読み込みの結果を作り、item の定義、読み飛ばしとモデルを読めないときの扱い、有効な item の判定をそこに置く

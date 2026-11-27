# リスク（`risk`）

## foundation

* [設定ファイルを上のディレクトリから拾うか、読んだ設定と暗黙の入力を info に誤って記録する](./config-discovery-or-info-record-wrong.md) - 設定ファイルを上のディレクトリから拾うか、読んだ設定と暗黙の入力を info に誤って記録する
* [結果エンベロープの形がサブコマンドによって食い違う](./envelope-shape-diverges-across-subcommands.md) - 結果エンベロープの形がサブコマンドによって食い違う
* [指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う](./finding-code-and-status-mismatch-strength.md) - 指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う
* [端末からの実行でないのに、人の確認や human: の generated.by を書く](./human-record-written-without-terminal.md) - 端末からの実行でないのに、人の確認や human: の generated.by を書く
* [読み飛ばされたファイルやモデルを読めないことを見逃し、欠けたグラフのまま検査や書き込みを続ける](./partial-graph-treated-as-complete.md) - 読み飛ばされたファイルやモデルを読めないことを見逃し、欠けたグラフのまま検査や書き込みを続ける
* [sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる](./sara-core-breaking-change-alters-results.md) - sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる
* [exit code、--json、--check、英語の text 出力がサブコマンドによって食い違う](./subcommand-interface-drift.md) - exit code、--json、--check、英語の text 出力がサブコマンドによって食い違う
* [時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う](./timestamp-misread-or-compared-as-string.md) - 時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う

## config-model

* [設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる](./config-alters-builtin-definitions.md) - 設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる
* [独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る](./custom-definitions-rejected-or-out-of-scope.md) - 独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る
* [設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す](./generated-model-diverges-from-config.md) - 設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す
* [init が既存の mitodoke.yaml を上書きするか、規範を適用先へ複製する](./init-overwrites-existing-config.md) - init が既存の mitodoke.yaml を上書きするか、規範を適用先へ複製する
* [不正な設定を受け付け、誤った前提で検査する](./invalid-config-accepted.md) - 不正な設定を受け付け、誤った前提で検査する

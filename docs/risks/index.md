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

## authoring

* [index の見出しと並びが置き場所と区分の表と食い違うか、--check が差分を見逃す](./index-generation-or-check-wrong.md) - index の見出しと並びが置き場所と区分の表と食い違うか、--check が差分を見逃す
* [new が置き場所の不一致、設定に無い区分、description の無い起票を受け付ける](./new-accepts-wrong-location-or-missing-description.md) - new が置き場所の不一致、設定に無い区分、description の無い起票を受け付ける
* [new が generated.by の出どころの優先順位か、拒む値の判定を誤る](./new-writes-wrong-provenance.md) - new が generated.by の出どころの優先順位か、拒む値の判定を誤る

## inspection

* [gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する](./gap-miscounts-valid-items-and-edges.md) - gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する
* [git と設定のコマンドを文書ごとに呼ぶか、辺の突き合わせが item の数の 2 乗で伸び、大きなグラフで CI の検査が使えなくなる](./inspection-time-grows-faster-than-graph.md) - git と設定のコマンドを文書ごとに呼ぶか、辺の突き合わせが item の数の 2 乗で伸び、大きなグラフで CI の検査が使えなくなる
* [強さの設定が働かず、失敗にする指摘を報告として扱うか、読み込みの前提まで設定で緩む](./strength-setting-misapplied.md) - 強さの設定が働かず、失敗にする指摘を報告として扱うか、読み込みの前提まで設定で緩む
* [check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない](./structural-violation-passes-check.md) - check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない
* [テスト資産の一覧の重複、除外、種別を読み誤り、test_case との 1:1 と対応表が狂う](./test-asset-inventory-misread.md) - テスト資産の一覧の重複、除外、種別を読み誤り、test_case との 1:1 と対応表が狂う

## freshness

* [generated の更新漏れで、本文に数える範囲か、基準のリビジョンが無い実行の扱いを誤る](./generated-update-omission-misjudged.md) - generated の更新漏れで、本文に数える範囲か、基準のリビジョンが無い実行の扱いを誤る
* [基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する](./stale-item-missed-or-overreported.md) - 基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する
* [人の確認の無い item、期限切れ、間隔の超過の報告で、数える verified か起点を誤る](./unverified-or-expiry-report-wrong.md) - 人の確認の無い item、期限切れ、間隔の超過の報告で、数える verified か起点を誤る
* [verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く](./verify-corrupts-item-or-writes-wrong-record.md) - verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く
* [verify が確認の問いを表示せずに記録するか、枝を上流から順にたどらない](./verify-skips-review-questions-or-walk-order.md) - verify が確認の問いを表示せずに記録するか、枝を上流から順にたどらない

## result-handoff

* [export の item の形が、sara 0.12 の items\[\] に OKF のキーを加えた形から外れる](./export-shape-drifts.md) - export の item の形が、sara 0.12 の items[] に OKF のキーを加えた形から外れる
* [draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる](./outturn-spec-change-breaks-conformance.md) - draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる
* [用語の一覧の JSON から用語か avoid の綴りが欠ける](./terms-json-incomplete.md) - 用語の一覧の JSON から用語か avoid の綴りが欠ける

## distribution

* [README の workflow の例が動かなくなるか、mitodoke 自身の CI と食い違う](./ci-example-diverges-from-own-ci.md) - README の workflow の例が動かなくなるか、mitodoke 自身の CI と食い違う
* [flake が、組み込んだ sara-core と違うタグの sara の CLI を配る](./flake-ships-mismatched-sara-cli.md) - flake が、組み込んだ sara-core と違うタグの sara の CLI を配る
* [設定ファイル、環境変数、コードの接頭辞の名前が製品名から外れる](./names-not-derived-from-product-name.md) - 設定ファイル、環境変数、コードの接頭辞の名前が製品名から外れる

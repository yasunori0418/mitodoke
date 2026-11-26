# 基盤（`infrastructure`）

* [ビルド・検証・リリースの基盤](./build-verification-and-release.md) - Rust のコードの整形・静的解析・カバレッジ・プラットフォームごとの検証、バージョンとタグ、sara の版の揃え、workflow の権限、受け入れテストの実行を支える基盤を draft で表す
* [リポジトリのホスティングの設定（issue フォーム・ラベル・ブランチの保護）](./repository-hosting-settings.md) - issue フォームとラベルで起票を分類語彙に通し、main の ruleset で PR を経ない変更と削除・force push を禁じるホスティングの設定
* [トレーサビリティ検証基盤（sara によるドキュメントグラフの機械検証）](./traceability-verification.md) - docs/ を sara のナレッジグラフとして扱い、紐付けの一貫性を CI の sara job と契約テストで機械検証する基盤

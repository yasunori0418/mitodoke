# 要求（`use_case`）

* [自分の製品に導入し、構成に合わせて設定する](./adopt-and-configure-for-own-product.md) - 利用者が、mitodoke を自分の製品のリポジトリに導入し、そのリポジトリの文書の構成と運用に合わせて設定する。
* [結果を CI やほかのツールへ渡す](./hand-results-to-ci-and-other-tools.md) - 利用者が、検査と再確認待ちの検出を CI で実行して契約違反や再確認が要る状態を開発の流れの中で明らかにし、その結果や成果物とその関係の構造化された情報をほかのツールへ渡す。
* [文書の契約と関係の制約を検査する](./inspect-contracts-and-relations.md) - 利用者が、item の構造と relation が文書の契約と関係の制約を満たしているかを機械に検査させ、欠けや不整合の報告を受け取る。
* [上流の変更で再確認が要る成果物を知り、人の確認を記録する](./review-stale-artifacts-and-record-verification.md) - 利用者が、上流の変更で再確認待ちになった下流の成果物を報告として受け取り、見直したうえで人間による確認を記録する。
* [品質に関わる成果物を item として起こし、関係を張る](./structure-quality-artifacts.md) - 利用者が、品質について検討・判断した結果を型の付いた item として書き、成果物どうしの関係を relation で明示する。

## 有効でない item（`deprecated`）

* [避ける綴りの検査を内蔵する](./builtin-avoid-spelling-check.md) - 利用者が、用語の避ける綴りが文書に無いことを mitodoke 自身に検査させ、検査を自分で組み立てずに済ませる。
* [テスト資産の列挙を内蔵する](./builtin-test-asset-enumeration.md) - 利用者が、適用先の製品のテスト資産を mitodoke 自身に列挙させ、列挙のコマンドも一覧のファイルも用意せずに test_case との対応を確かめる。
* [欠陥の Issue を検査し、トラッカー用の雛形を配る](./defect-issue-inspection-and-tracker-templates.md) - 利用者が、欠陥の Issue のラベルや本文の型を mitodoke に検査させ、トラッカー用の雛形を製品から受け取る。
* [出来事をグラフに記録する](./events-recorded-in-graph.md) - 利用者が、テストの実行の記録、観測の結果、欠陥、受け取ったフィードバックといった出来事を item としてグラフに記録する。
* [既存の文書に generated を埋め戻す](./generated-backfill-for-existing-documents.md) - 既存の文書を持つ利用者が、mitodoke を導入するときに、mitodoke の CLI で既存の item に generated を埋め戻す。
* [文書管理の規範を、初期化のコマンドで適用先の製品へ複製する](./norms-copied-by-init-command.md) - 利用者が、初期化のコマンドで、mitodoke の文書管理の規範を雛形の item として自分の製品のグラフへ複製する。
* [テスト実行基盤やログ集約基盤になる](./test-runner-and-log-aggregation.md) - 利用者が、適用先の製品のテストの実行とテストランナーの管理を mitodoke に任せ、実行の記録とログを mitodoke に集める。

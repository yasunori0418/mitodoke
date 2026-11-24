# テスト計画（`test_plan`）

* [CLI の受け入れは、写した契約テストで確かめる](./acceptance-by-copied-contract-tests.md) - mitodoke の CLI の受け入れは、写した契約テストで、result.info の下の JSON のキー・exit code・起票の id: と file: の 2 行を写した fixture と同じ期待で確かめる。
* [outturn への適合は受け入れテストで --json の出力のサンプルを schema に照らして確かめる](./outturn-conformance-by-schema-check.md) - outturn への適合を受け入れテストの範囲に入れ、mitodoke の --json の出力のサンプルを outturn の flake の lib.mkSchemaCheck で確かめ、item の id の導出は確かめない。
* [mitodoke 自身のテストは 7 つの区分に分け、単体のテストと受け入れテストの 2 つのレベルで確かめる](./test-levels-and-scope.md) - mitodoke 自身のテストを 7 つの区分に分けて単体のテストと受け入れテストの 2 つのレベルで確かめ、受け入れテストは fixture だけに依って、写した契約テストの期待 141 行のうち 110 行を引き継ぐ。

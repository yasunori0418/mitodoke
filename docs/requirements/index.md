# 要件（`requirement`）

## 製品の範囲と構成

* [設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める](./names-derived-from-product-name.md) - 製品名を含むコマンド・設定ファイル・環境変数・エラーと警告のコード・crate と製品が自身のために定める flake の出力の名前は、製品名 mitodoke から決める
* [製品は CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含む](./product-contents.md) - mitodoke の製品は CLI とモデルに加えて文書管理の規範・スキル・欠陥運用の規範を含み、開発の進め方の規範と DoD は含まない
* [1 つの CLI が、サブコマンドごとに入力・出力・exit code を定める](./single-cli-subcommand-contracts.md) - mitodoke は文書の検査・起票・生成を 1 つの CLI のサブコマンドとして持ち、サブコマンドごとに入力・出力・exit code を定める

## モデルと設定

* [組み込みの定義は設定で削除も変更もできない](./builtin-definitions-immutable.md) - 設定は独自の型・relation・フィールドを追加できるが、組み込みの型・relation・フィールドを削除も変更もできない。
* [設定ファイルは YAML の mitodoke.yaml とする](./config-file-format.md) - 設定ファイルは YAML の mitodoke.yaml とし、独自の型・relation・フィールドは sara の model.yaml と同じ書き方で書けるようにする。
* [検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける](./inspection-scope-for-custom-types.md) - 組み込みの型・relation・フィールドの名前を条件に持つ契約は組み込みの型の item だけに、それ以外の契約は独自の型を含むすべての型の item に働かせる。
* [model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる](./model-and-sara-toml-generated-from-config.md) - model.yaml と sara.toml は設定ファイルから生成してコミットし、生成し直した結果との差分が無いことを CI で確かめる。
* [level の導出表は設定で変えられ、設定が無ければ既定の表を使う](./risk-matrix-configuration.md) - risk の level を likelihood と impact から導く表は設定で変えられ、設定に無ければ既定の表を使い、値の集合は製品で固定する。
* [specification は英語で必須とし、ほかの言語のフィールドは設定から生成する](./specification-languages.md) - specification は英語で必須とし、設定で選んだほかの言語ごとに specification_<言語> と name_<言語> のフィールドを生成する。
* [独自の relation は、再確認待ちを伝播させるかを設定で宣言する](./staleness-propagation-declared-for-custom-relations.md) - 再確認待ちの判定は、組み込みの 7 relation に加えて、設定で伝播させると宣言した独自の relation も辿る。
* [テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く](./test-categories-from-config.md) - テストの区分は製品の概念で、中身は設定の 1 つの一覧で決め、テスト条件とテストケースの置き場所・risk の section の値・index の見出しをその一覧から導く。
* [組み込みの型は 12 型で、すべて必須とする](./twelve-builtin-types.md) - 製品の組み込みの型は 12 型とし、どの適用先の製品でもすべてを持ち、設定で選ばない。
* [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](./type-locations-in-config.md) - 設定に型ごとの置き場所を持ち、item の型と置き場所の一致を構造の契約として確かめ、index の見出しも同じ表から決める。

## 検査

* [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](./constraints-on-top-of-okf.md) - OKF v0.2 の定義に重ねた 5 つの制約を持ち、verified の形・generated・status を構造の契約として検査し、description の欠けは mitodoke new が起票で拒み、人の確認は generated.at 以降の verified だけを数える。
* [検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](./default-inspection-strength.md) - 検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は報告とし、どの検査の強さも設定で変えられるようにする。
* [fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する](./fresh-reports-unverified-validation-and-expiry.md) - mitodoke fresh は人の確認の無い有効な solution と use_case、stale_after の期限切れ、stale_after の間隔の超過を見直しの義務として報告する。
* [gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする](./gap-reports-upstream-and-quality-characteristic-gaps.md) - mitodoke gap は有効な requirement を持たない有効な use_case、親の use_case がすべて deprecated の有効な requirement、有効な risk を持たず対象外にもしていない品質特性をつながりの欠けとして報告し、human_judgement を持つ有効な test_condition を情報として一覧にする。
* [OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する](./okf-key-inspection.md) - OKF のキーをどの型の item でも受け付け、その形と値が OKF v0.2 の定義に従っているかを構造の契約として検査する。
* [用語の一覧と avoid を JSON で出力する](./terms-and-avoid-exported-as-json.md) - 用語の一覧と各用語の avoid を JSON で出力し、避ける綴りの検査そのものは mitodoke に持たない。
* [test_case は covers と follows をそれぞれ 1 本以上持たなければならない](./test-case-link-contract.md) - test_case が covers と follows をそれぞれ 1 本以上持つことを構造の契約とし、どちらかが欠けた test_case を違反とする。
* [宣言の無い frontmatter のキーは構造の契約の違反とする](./undeclared-frontmatter-keys.md) - sara の組み込みのキー、OKF の 4 つのキー、その item の型で宣言されたフィールドと relation のどれでもない frontmatter のキーを構造の契約の違反とする。

## コマンド

* [generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む](./generated-by-format.md) - generated.by の値は書式を限らず、空の値と二重引用符・バックスラッシュ・改行を含む値だけを拒み、値を判定には使わない。
* [generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする](./generated-by-source.md) - mitodoke new は generated.by を MITODOKE_GENERATED_BY か --by から取り、どちらも無いときは端末からの実行に限り human:<id> を書き、端末の無い実行では起票を拒む。
* [人の確認に書く識別子は設定のコマンドの出力から取り、不正な出力では何も書かない](./human-id-command.md) - mitodoke verify は、human:<id> の <id> を設定に定義したコマンドの出力から取り、出力が不正なときやコマンドが失敗したときは何も書かずにエラーにする。
* [verify は端末での人の入力があるときだけ人の確認を記録する](./human-verification-recording.md) - mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を記録し、端末の無い実行では拒む。
* [init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、既存の mitodoke.yaml を上書きしない](./init-creates-config-and-directories.md) - mitodoke init は、初期の mitodoke.yaml と、設定が型ごとに持つ置き場所のディレクトリを作り、mitodoke.yaml がすでにあるときは上書きせずに拒み、文書管理の規範を適用先の製品へ複製しない。
* [item を指定しない verify は、対話で選んだ枝を上流から順にたどって人の確認を記録する](./interactive-verification-walk.md) - item を指定しない mitodoke verify は、対話で枝を選ばせ、上流から順に item を表示して人の確認を記録し、表示のビューアとコメントのエディタを mitodoke.yaml で設定できるようにする。
* [new は引数の置き場所を型ごとの置き場所と比べ、合わなければ起票を拒む](./new-location-check.md) - mitodoke new は置き場所を引数で受け取り、設定の型ごとの置き場所と合わない起票を拒む。
* [サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](./subcommand-set.md) - mitodoke の CLI は、初期化・起票・報告・生成・確認の記録・出力・検査を、機能ごとに分けた 10 個のサブコマンドで提供する。
* [テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](./test-asset-inventory-sources.md) - mitodoke はテスト資産の列挙を内蔵せず、設定に書いた列挙のコマンドの出力とコミットした一覧のファイルを合わせて 1 つの一覧にし、同じ資産識別子が 2 か所から出たら失敗にする。
* [verify は、solution と use_case の確認を記録する前に確認の問いを表示する](./verify-shows-review-questions.md) - mitodoke verify は solution と use_case に人の確認を記録する前に、その型に当てる確認の問いを表示し、答えは記録しない。

## JSON 出力

* [設定ファイルは作業ディレクトリから読み、作業ディレクトリと設定ファイルのパスを info に記録する](./config-discovery-and-record.md) - mitodoke は --config を省いたとき作業ディレクトリの設定ファイルだけを読み、実行時の作業ディレクトリと読んだ設定ファイルの絶対パスをエンベロープのトップレベルの info に記録する。
* [契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す](./error-and-warning-codes.md) - 契約の違反は E_MITODOKE_<契約名>、報告は W_MITODOKE_<契約名> のコードで表し、入力や環境の誤りには outturn の共通コードを使う。
* [export は文書 1 件を item とし、sara 0.12 の items\[\] の形に OKF のキーを加えて出す](./export-shape.md) - export は文書 1 件ずつを item にし、sara 0.12 の items[] の形を写して OKF のキーを加えたものを item の info の下に置き、sara の形が変わっても自動では変えない。
* [サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない](./json-outturn-envelope.md) - mitodoke のすべてのサブコマンドは --json を選んだときだけ outturn に適合する結果エンベロープを出し、既定の text 出力は変えない。
* [check・gap・fresh の item は契約と文書の組を単位とする](./result-item-unit.md) - check・gap・fresh の結果エンベロープは、1 つの文書が 1 つの契約に反したことを item 1 つで表し、成り立った組は item にしない。

## 配布と運用

* [CI 連携は CLI と workflow の例で提供する](./ci-integration-form.md) - CI 連携を CLI と README の workflow の例で提供し、action を配らないことを定める。
* [Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配る](./distribution-by-nix-flake.md) - mitodoke を Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配ることを定める。
* [利用者向けのスキルは公開用として英語で書く](./user-facing-skills.md) - mitodoke が利用者向けに公開するスキルを英語で書くことを定める。

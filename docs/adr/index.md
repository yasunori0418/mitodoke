# ADR（`adr`）

## グラフのモデル

* [ADR の justifies 対象を specification を持つ全型に広げる](./adr-justifies-quality-and-test-plan.md) - ADR 系の型の `justifies` は、`requirement` / `design` / `infrastructure` だけを対象にしていた。quality とtest_plan を設けた（[テスト計画の型を品質方針の型から分けて設ける](quality-and-test-plan-types.md)）ことで、規範の文を持つ型が増えた。 (stable)
* [design の satisfies 対象に test_plan を含める](./design-satisfies-test-plan.md) - design の `satisfies` は `requirement` だけを対象にしていた。テスト計画にあたる `requirement` を test_plan へ移す（[テスト計画の型を品質方針の型から分けて設ける](quality-and-test-plan-types.md)）と、それらを `satisfies` で指していた design item の辺は張り先を失う。中には `satisfies` がその 1 本だけの design item もあり、移した途端に design 側が接続漏れになる。 (stable)
* [保証する連鎖は requirement → risk → test_condition → test_case とし、design は任意の中継点にする](./guaranteed-chain-design-optional.md) - 要件からテストまでで保証する連鎖を requirement → risk → test_condition → test_case に定め、requirement に design を必須にせず、risk を持たない design を正常とする。 (stable)
* [infrastructure 型を改名しない](./infrastructure-name-kept.md) - infrastructure を技術基盤として定義し直した（[infrastructure を技術基盤として再定義し root から外す](infrastructure-redefined-non-root.md)）とき、型名が内容に合っているかが問題になった。違和感の主な原因は、品質系の文書と基盤系の文書の同居だった。 (stable)
* [infrastructure を技術基盤として再定義し root から外す](./infrastructure-redefined-non-root.md) - infrastructure は root の型として定義されていた。satisfy できる相手が design しか無く、CI やトレーサビリティ検証のような開発の基盤は design の木に属さないため、root にせざるを得なかった。その結果、`docs/infrastructure/` の item は全件が構造上の接続漏れだった。 (stable)
* [model.yaml で組み込みモデルを全面置換し、汎用の型名を使う](./model-yaml-full-replacement.md) - sara は組み込みのモデル（型と relation）を持ち、カスタムスキーマで置き換えられる。置き換えは全面で、部分的なマージはできない。組み込みには `hardware_requirement` や `system_architecture` のように、layat に対応する実体の無い型が含まれる。 (stable)
* [テスト計画の型を品質方針の型から分けて設ける](./quality-and-test-plan-types.md) - テスト計画や品質方針にあたる文書は、受け皿の型が無いため `requirement` として置かれていた。`requirement` の親は use_case だが、これらの文書は「ユーザーがどう使うか」から導かれないので親を持てず、接続漏れのまま残っていた。 (stable)
* [test_case から test_plan へ follows を張る](./test-case-follows-test-plan.md) - test_plan とテストをつなぐ辺を test_case から test_plan への新設 relation follows とし、test_case の親に test_plan を足す。 (stable)
* [用語は ubiquitous_term の item で管理し、一覧は生成した index.md が持つ](./ubiquitous-terms-listed-by-generated-index.md) - 用語は 1 語 1 ファイルの ubiquitous_term の item で管理し、語の一覧は `docs/ubiquitous-language/index.md` に生成して、`docs/glossary.md` と glossary-index の契約テストは廃止する (stable)
* [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](./upper-layers-validated-by-review-questions.md) - 上位 2 層の solution と use_case は、確認の問いに人が答える妥当性確認でカバーし、risk の threatens の先は広げない。 (stable)
* [use_case を要求、requirement を要件に対応させる](./use-case-and-requirement-terms.md) - 型名 use_case に日本語の要求を、requirement に日本語の要件を対応させ、モデルの読み方に書く。 (stable)

## ID・ファイル名・起票

* [ADR は UUID だけで採番する](./adr-uuid-only-numbering.md) - 連番で採番していた旧 ADR は、UUID で採番する新 ADR と並べて `legacy_adr` 型に凍結していた。旧 ADR の決定は 1 決定 1 ADR の新 ADR へすべて移り、旧 ADR は全部 `廃止` になった。docs/adr の外の参照も新 ADR の ID へ付け替え終えている。 (stable)
* [frontmatter の外のフル ID と省略形は起票の機械化と契約テストで防ぐ](./frontmatter-only-ids-checked-by-contract-test.md) - フル ID の書き場所と 8 文字省略形の禁止を、起票ラッパーによる機械化と契約テスト link-text.sh の検出で担保する。 (stable)
* [フル ID は frontmatter だけに書き、item にはリンクで触れる](./full-ids-in-frontmatter-only.md) - フル ID の書き場所を frontmatter の id と relation リストに限り、H1 見出しは name だけにし、本文や specification などの文字列では item へ Markdown リンクで触れる。 (stable)
* [sara-id を廃止し sara init を包む起票ラッパーで slug のファイル名を適用する](./sara-new-wrapper-applies-slug-filename.md) - 採番を `sara init` に任せ、薄い起票ラッパー `sara-new` が `<slug>.md` のファイル名規約の適用、`--description` の必須チェック、`generated` の付与を担う。 (stable)

## frontmatter のキー

* [ADR の issues を sources に移す](./adr-issues-to-sources.md) - ADR の外部参照の Issue を OKF の sources リストへ移し、origin は拡張キーとして残す (stable)
* [adr の status_note を持たない](./adr-status-note-removed.md) - ADR のステータス行には「採用（2026-06-14 改訂: … → ADR-0015）」のようなカッコ書きの改訂注記が付いていた。enum の値に収まらないので、frontmatter に `status_note` フィールドを設けて受け皿にしていた。 (stable)
* [item にできない外部参照は text フィールドへ逃がす](./external-references-as-text-fields.md) - ADR は GitHub の Issue や、決定の起点になったセッションを参照する。これらは sara の item ではないので、relation では表せない。relation の参照先は実在する item でなければならず、実在しない ID は破損した参照として検出される。 (stable)
* [item に生成者・確認の記録・期限を持たせる](./generated-verified-stale-after.md) - 生成者と時刻の generated を必須にし、確認の記録 verified と期限 stale_after を任意で持たせ、入れ子キーの形を契約テストで確かめる (stable)
* [OKF v0.2 と互換の frontmatter キーを item に足す](./okf-compatible-frontmatter.md) - OKF v0.2 と互換の frontmatter キーを sara の item に足す方針と、バンドル単位の適合を追わない範囲を決める (stable)
* [status を OKF の 3 値にし全ての型に持たせる](./status-okf-values.md) - status を draft / stable / deprecated の 3 値にし、ADR 以外の型にも必須で持たせる (stable)
* [test_case の target を resource に改名する](./test-case-resource-field.md) - test_case のテスト資産の正準表記を OKF の resource キーで持ち、値はリポジトリ根からのパスのままにする (stable)

## 機械検証と鮮度

* [鮮度は上流の relation を辿って下流へ伝播させる](./freshness-propagates-along-upstream-relations.md) - 下流の item の基準時刻より上流の generated.at が新しければ、上流の relation のうち justifies を除く 7 種を辿って下流を再検証待ちとして挙げる (stable)
* [generated の更新漏れは PR の差分で確かめる](./generated-update-checked-in-pr-diff.md) - base との差分で本文が変わったのに generated.at が変わっていない item を挙げ、全履歴と時刻は比べない (stable)
* [level が high の risk と、有効な solution と use_case に人の verified を求める](./human-verified-required-for-high-risk-and-upper-layers.md) - level が high の risk と、status が deprecated でない solution と use_case 自身に、generated.at 以降の human: の verified を求め、medium・low の risk と TC・CASE には求めない。 (stable)
* [sara check を strict モードで回す](./sara-check-strict-mode.md) - `sara check` は接続漏れを warning に留める設定で導入された。移行の途中では、まだ親を持たない item が正常に存在し、接続漏れを error にすると移行そのものが止まるためである。 (stable)

## ADR と規範文の書き方

* [ADR は単独で覆せる 1 つの決定だけを書く](./adr-one-decision-granularity.md) - layat の ADR は、1 本に複数の決定を束ねて書いてきた。後から 1 つの決定だけを変えると、元の ADR に改訂注記を足して「この節だけが変わった」と示すしかない。改訂を 4 回以上受けた ADR は 13 本あり、どの決定がいまも有効かは注記を順に読んで組み立て直さないと分からなくなっていた。 (stable)
* [ADR の失効は supersedes と 廃止 で表す](./adr-supersedes-and-deprecated-status.md) - `docs/model.yaml` は、ADR 間の関係として節単位の部分改訂を表す `revises` だけを持っていた。文書丸ごとの失効を表す `supersedes` と、ステータスの `廃止` は持たなかった。当時は丸ごと失効したADR の実例が無く、実例の無い関係を先に置くと部分改訂に誤用されると考えたためである。 (stable)
* [item の出典は分割した時点のパスのまま残す](./provenance-keeps-split-time-paths.md) - item の `## 出典` にある分割した時点の文書のパスは書き換えず、出典の読み方は `docs/model.md` の 1 か所に置く (stable)
* [棄却した提案の要件と設計は提案の形の題で deprecated にして残す](./rejected-proposals-deprecated.md) - 棄却した提案を記録する要件と設計は、提案の形の題と本文に棄却の記述を添え、status を deprecated にして残す。 (stable)
* [specification の必須の強度を SHALL 系の綴りに固定する](./specification-shall-family-fixed.md) - specification の必須の強度は SHALL 系だけで書き、specification_ja は同じ強度の規範助動詞で終える。 (stable)

## 文書の配置と index.md の生成

* [deprecated の item は index.md の末尾の節にまとめる](./deprecated-items-listed-at-index-end.md) - index.md は status が deprecated の item を主題の並びと section の節から外し、末尾の「有効でない item」の節にファイル名順でまとめて出す (stable)
* [ドキュメントは sara のナレッジグラフとして item に分割する](./docs-as-sara-knowledge-graph.md) - layat の仕様・設計・テストは、`docs/spec.md`・`docs/design.md`・`docs/concept.md` と ADR に散文で書かれていた。この形では、要求とリスクの紐付けが一貫しているかを機械的に確かめられない。 (stable)
* [index.md の節は 6 つの型で item の section から生成する](./index-sections-in-six-types.md) - requirement・design・ubiquitous_term・adr・sara_adr・risk の index.md は、item が持つ必須の enum フィールド section ごとに節を分けて生成し、値は item に手で書く (stable)
* [item の一覧は生成した index.md だけが持つ](./item-lists-held-by-generated-index.md) - 型ごとの item の一覧は okf-index.sh が生成する index.md だけが持ち、手書きの文書は一覧を持たず、item を足したときは index.md を再生成するだけにする (stable)
* [OKF の index.md を sara check の出力から生成してコミットする](./okf-index-generation.md) - OKF の index.md を sara check --format json から生成し、コミットして契約テストで差分ゼロを守る (stable)
* [sara の運用規範は quality の item が持ち、規約文書は図と索引に縮退させる](./operational-norms-held-by-quality-items.md) - sara の運用規範を規約文書の散文から 1 主張 1 本の quality item へ移し、規約文書は図と item への索引だけにする。 (stable)
* [手書きの概要は各ディレクトリの README.md に置く](./overview-prose-in-directory-readme.md) - item から導けない全体像の散文は、その主題の item を置くディレクトリの README.md に置き、README.md は frontmatter と item の一覧を持たず、同じディレクトリの index.md を 1 本だけ指す (stable)
* [risk の節はテストの区分と同じ語彙にする](./risk-sections-follow-test-categories.md) - risk の section の値・節の並び順・見出しは dev/tests/test-categories.tsv のテストの区分と同じにし、enum と区分の一致を契約テストが確かめる (stable)
* [用語の index.md はリンク文字列に name_ja を添える](./term-index-shows-name-ja.md) - 用語の index.md は、name_ja を持つ語のリンク文字列を name（name_ja）にし、英語と日本語のどちらの正名からも語を引けるようにする (stable)

## risk・テスト系 item・欠陥

* [欠陥 issue のクローズ時にテスト系 item の欠落を追補する](./defect-close-backfills-risks.md) - [欠陥はグラフに置かず GitHub Issues で管理する](defects-in-github-issues.md)。グラフのrisk / test_condition は予防の体系だが、起きた欠陥から学ばなければ、ある時点の分析を写したまま古びていく。 (stable)
* [欠陥を既存の RISK / TC に辿れたかで分類して数える](./defects-classified-by-risk-foresight.md) - 欠陥の Issue をクローズするときに、対応する risk か test_condition が起票の時点で既にあったかで欠陥を 2 つに分類し、固定した語彙で記録して数えられるようにする。 (stable)
* [欠陥はグラフに置かず GitHub Issues で管理する](./defects-in-github-issues.md) - グラフには欠陥を表す defect 型があった。defect は自分から upstream relation を張れず、親側の test_case が下流向きの `reveals` で接続する唯一の型だった。そのため次の例外を抱えていた。 (stable)
* [自動検証の形骸化は守備対象の impact を継承し、継承元をリンクで名指しする](./gate-risk-inherits-impact-by-link.md) - 自動検証の形骸化を表す risk の `impact` は守備対象の regression から継承し、継承元はその regression を持つ risk への Markdown リンクで名指しする。 (stable)
* [requirement に risk_exempt を設け、理由を書いた requirement を未カバーから外す](./requirement-risk-exempt.md) - requirement に任意フィールド risk_exempt を設け、requirement 水準の risk を持たない理由を 1 文で書いた requirement を未カバーの一覧から外して免除として列挙する。 (stable)
* [risk の張り先は requirement を既定にし、threatens の 1 本ごとに判定する](./risk-attaches-to-requirement-by-default.md) - risk は既定で requirement に張り、設計を差し替えると消える懸念だけを design に張る。判定は threatens の 1 本ごとに行う。 (stable)
* [複数の失敗方向を持つ risk は最も重い方向で採点する](./risk-heaviest-direction.md) - [risk の impact を検出後の回復可能性で採点する](risk-impact-as-recoverability.md) と決めた。1 つのrisk が複数の失敗の仕方を持ち、方向によって回復できる度合いが違うとき、どの方向で採点するかを決める必要があった。 (stable)
* [risk の impact を検出後の回復可能性で採点する](./risk-impact-as-recoverability.md) - risk の `impact` の high 行は、「ユーザー環境・実データの破壊」と「沈黙の不整合を残すこと」を並べていた。気づかれないまま通る脅威は、開発の中に留まるものでも high を採る読み方だった。 (stable)
* [risk の親に test_plan を含めない](./risk-parent-excludes-test-plan.md) - test_plan を設けた（[テスト計画の型を品質方針の型から分けて設ける](quality-and-test-plan-types.md)）ことで、risk の親に test_plan を加えるかどうかを決める必要があった。テスト計画はどの risk を扱うかを述べるので、両者には関係がある。 (stable)
* [沈黙性を risk のスコア軸にせず本文に書く](./silence-not-a-score-axis.md) - [risk の impact を検出後の回復可能性で採点する](risk-impact-as-recoverability.md) と決め、`impact` から沈黙の不整合を外した。気づけるかどうかは脅威の性質として重要な情報で、捨てるには惜しい。これをどこに残すかを決める必要があった。 (stable)
* [テスト系 item を CASE・TC・RISK の 3 段で起こす](./test-items-in-three-tiers.md) - CASE はテスト資産、TC は検証テーマ、RISK は TC を束ねる脅威の単位で起こす (stable)

## 製品の範囲と構成

* [規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する](./norms-kept-in-own-repository.md) - mitodoke のリポジトリ自身を mitodoke で管理して規範と文書管理の決定を持ち、適用先の製品は規範を写さず mitodoke の文書として参照する (stable)
* [製品に CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含める](./product-bundles-cli-model-norms-skills.md) - 製品の範囲を CLI とモデルに加えて文書管理の規範・スキル・欠陥運用の規範までとし、開発の進め方の規範と DoD は含めない (stable)
* [製品名を mitodoke にする](./product-named-mitodoke.md) - 製品名を、日本語の見届けに由来する mitodoke にし、製品名を含む名前をすべてこの名前から決める (stable)
* [Rust で書き、sara-core を crate として組み込む](./rust-cli-embedding-sara-core.md) - CLI を Rust で書き、sara の CLI を subprocess で呼ばずに sara-core を crate として直接使い、使う箇所を 1 つのモジュールに集める (stable)
* [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](./single-cli-with-subcommands.md) - 契約ごとの検査を独立した実行ファイルに分けず、1 つの CLI がサブコマンドとして内部に持ち、外部ツールは sara と git などに限る (stable)

## モデルと設定

* [設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする](./config-file-mitodoke-yaml.md) - 設定ファイルは YAML の mitodoke.yaml とし、独自の型・relation・フィールドは sara の model.yaml と同じ書き方で書く。 (stable)
* [独自の型・relation・フィールドは追加だけを許す](./custom-definitions-additive-only.md) - 設定では型・relation・フィールドのすべてを独自に追加でき、組み込みの定義は削除も変更もできない。 (stable)
* [再確認待ちは、設定で宣言した独自の relation も辿る](./custom-relations-declare-staleness-propagation.md) - 再確認待ちの判定は、組み込みの 7 relation に加えて、設定で伝播させると宣言した独自の relation も辿る。 (stable)
* [model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](./model-generated-from-config.md) - 適用先の製品の model.yaml は mitodoke の設定ファイルから生成してコミットし、生成結果との差分が無いことを CI で確かめる。 (stable)
* [level の導出表を設定で変えられるようにし、値の集合は固定する](./risk-matrix-configurable-values-fixed.md) - likelihood と impact の組から level への対応を設定で変えられるようにし、設定に無ければ既定の 9 通りの表を使い、low・medium・high の値の集合は製品で固定する。 (stable)
* [specification は英語で必須にし、ほかの言語は設定で選ぶ](./specification-english-required-other-languages-configured.md) - specification は英語で必須にし、ほかの言語は設定で選んで specification_<言語> と name_<言語> のフィールドを生成する。 (stable)
* [テストの区分を製品の概念にし、中身は設定で決める](./test-categories-configured-per-product.md) - テストの区分を製品の概念にして中身を設定の 1 つの一覧で決め、テスト条件とテストケースのディレクトリ・risk の section・index の見出しをその一覧から導く。 (stable)
* [組み込みの型を 12 型にし、すべて必須にする](./twelve-builtin-types-all-required.md) - 製品の組み込みの型は sara_adr を含まない 12 型とし、すべてを必須にして設定では選ばない。 (stable)
* [型と置き場所の一致を構造の契約にし、型ごとの置き場所を設定に持つ](./type-location-match-is-structural-contract.md) - item の型と置き場所の一致を構造の契約に加え、型ごとの置き場所を設定に持って index の見出しも同じ表から決める。 (stable)
* [型に固有の契約は組み込みの型だけに働かせる](./type-specific-contracts-builtin-only.md) - frontmatter の形・ID の置き場所・index.md の生成と差分はすべての型に、型に固有の契約は組み込みの型だけに働かせる。 (stable)

## 検査

* [避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる](./avoid-spelling-check-left-to-adopters.md) - 用語の避ける綴りの検査を mitodoke に内蔵せず、mitodoke の JSON 出力を使って適用先の製品が検査を組み立てる。 (stable)
* [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする](./default-strength-fail-structure-report-gaps.md) - 検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は CI での報告とし、どの検査も設定で強さを変えられるようにする。 (stable)
* [human: 以外の verified も受け付け、基準時刻には数えるが人の確認には数えない](./non-human-verified-accepted-not-counted-as-human.md) - verified に human: 以外の要素も受け付け、再確認待ちの基準時刻には数えるが、人の確認には数えない。 (stable)
* [OKF のキーは型を問わず受け付け、OKF v0.2 の定義に従うかを検査する](./okf-keys-accepted-on-all-types.md) - OKF のキーをどの型の item でも受け付け、OKF v0.2 の定義に従っているかを構造の契約として検査する。 (stable)
* [OKF より厳しい 5 つの制約を構造の契約に引き継ぐ](./stricter-than-okf-constraints-kept.md) - 写した文書管理の仕組みが OKF v0.2 に重ねて定めた 5 つの制約を、すべて mitodoke の構造の契約に引き継ぐ。 (stable)
* [test_case は covers と follows をそれぞれ 1 本以上持つ](./test-case-requires-covers-and-follows.md) - test_case が covers と follows をそれぞれ 1 本以上持つことを構造の契約にし、欠けたら失敗にする。 (stable)
* [トラッカーに依らない欠陥運用の規範を製品に含め、欠陥の Issue は検査しない](./tracker-independent-defect-norm-shipped.md) - トラッカーに依らない欠陥運用の規範を製品に含め、GitHub 用の部分は例として置き、mitodoke は欠陥の Issue を検査しない。 (stable)
* [宣言の無い frontmatter のキーを構造の契約の違反にする](./undeclared-frontmatter-keys-rejected.md) - sara の組み込みのキーでも、model で宣言されたフィールドや relation でもない frontmatter のキーを構造の契約の違反として mitodoke check で失敗にし、OKF のキーは違反にしない。 (stable)

## コマンド

* [generated.by は自由な文字列にする](./generated-by-free-form-string.md) - generated.by の値は書式を限らない自由な文字列とし、空の値と二重引用符・バックスラッシュ・改行を含む値だけを拒む。 (stable)
* [generated.by は環境変数か引数で受け取り、無ければ端末に限り人の識別子にする](./generated-by-from-env-or-flag.md) - mitodoke new は generated.by を MITODOKE_GENERATED_BY か --by で受け取り、どちらも無いときは端末からの実行に限り human:<id> を作り、端末の無い実行では起票を拒む。 (stable)
* [人の識別子は、設定に定義したコマンドの出力から取る](./human-id-from-configured-command.md) - mitodoke verify が書く human:<id> の <id> は、mitodoke.yaml に定義したコマンドを利用者の環境で実行した出力から取り、不正な出力では何も書かない。 (stable)
* [new は置き場所を引数で受け取り、型ごとの置き場所と比べる](./new-takes-location-argument.md) - mitodoke new は置き場所を引数で受け取り、設定の型ごとの置き場所と比べて、合わなければ起票を拒む。 (stable)
* [サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける](./subcommands-split-by-function.md) - mitodoke の CLI のサブコマンドは、開発に使う script の名前から接頭辞を外した名前で、機能ごとに分ける。 (stable)
* [テスト資産の列挙は内蔵せず、設定のコマンドかコミットしたファイルから読む](./test-assets-listed-by-configured-sources.md) - mitodoke はテスト資産の列挙を内蔵せず、設定に書いた列挙のコマンドの出力とコミットした一覧のファイルを併用して読む。 (stable)
* [verify は、端末で人が確認を入力したときだけ確認の記録を書く](./verify-records-human-only-from-terminal.md) - mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を書き、端末の無い実行では拒む。 (stable)

## JSON 出力

* [設定ファイルは作業ディレクトリのものだけを読み、読んだパスを info に記録する](./config-read-from-working-directory-and-recorded.md) - 設定ファイルの指定を省いたときは作業ディレクトリのものだけを読み、実行時の作業ディレクトリと読んだ設定ファイルの絶対パスをエンベロープのトップレベルの info に記録する。 (stable)
* [写した契約テストを CLI の受け入れテストにする](./contract-tests-as-cli-acceptance-tests.md) - 写した契約テストを mitodoke の CLI の受け入れテストにし、outturn の result.info の下の JSON のキー・exit code・起票の id: と file: の 2 行を揃え、text 出力の見出しと行の形式は揃えない。 (stable)
* [export は sara 0.12 の items\[\] の形を写して固定し、OKF のキーを加える](./export-shape-fixed-from-sara-items.md) - export の形は今の sara 0.12 の items[] を写して mitodoke の形として固定し、OKF のキーを加えて outturn の item の info の下に置き、sara の形が変わっても自動では変えない。 (stable)
* [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](./json-output-conforms-to-outturn.md) - mitodoke のすべてのサブコマンドの --json を outturn の結果エンベロープにし、§8 の standalone まで含めて適合させ、既定の text 出力は変えない。 (stable)
* [check・gap・fresh の item を契約 × 文書の単位にする](./result-items-per-contract-and-document.md) - check・gap・fresh の結果は、1 つの文書が 1 つの契約に反したことを item 1 つで表し、kind を契約の名前、key を文書の ID にして、成り立った組は item にしない。 (stable)
* [契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える](./tool-specific-error-and-warning-codes.md) - 契約の違反と報告は E_MITODOKE_<契約名> と W_MITODOKE_<契約名> のツール別のコードで統一し、強さの設定で接頭辞だけを切り替え、入力や環境の誤りには outturn の共通コードを使う。 (stable)

## 配布と運用

* [CI 向けには CLI と workflow の例だけを用意し、action は配らない](./ci-integration-by-cli-and-workflow-example.md) - CI 連携のために CLI と README の workflow の例だけを用意し、action は配らないと決める。 (stable)
* [Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る](./distributed-by-nix-flake-with-sara-cli.md) - mitodoke を Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配ると決める。 (stable)
* [sara は必要なときに上げ、Cargo.lock と flake の input を同じタグに揃える](./sara-upgraded-when-needed.md) - sara のタグは要る機能や修正が入ったときに上げ、Cargo.lock と flake の input を同じタグへ揃えると決める。 (stable)
* [利用者向けのスキルを公開用として英語で書く](./user-skills-written-in-english.md) - 利用者向けのスキルを公開用として英語で書き、配り方は候補を挙げて Issue #46 で決めると決める。 (stable)

## 移し方と記録

* [写した shell script で自身の文書を管理し、CLI が完成したら置き換える](./copied-scripts-until-cli-replaces-them.md) - mitodoke 自身の文書を写した shell script で管理し、CLI が完成したら CLI で置き換えると決める。 (stable)
* [決定は adr に、作業は Issue に記録する](./decisions-in-adr-work-in-issues.md) - grilling の決定は mitodoke のリポジトリの adr に、実装の作業は mitodoke の Issue に記録すると決める。 (stable)
* [文書管理の規範と決定は、写した時点から mitodoke だけで変える](./norms-changed-only-in-mitodoke-after-copy.md) - layat から写した時点から、文書管理の規範と決定を mitodoke だけで変えると決める。 (stable)

## 有効でない item（`deprecated`）

* [ADR の規則を汎用とプロジェクト当てはめに分けて書く](./adr-rules-generic-and-project-split.md) - ADR の規則は `docs/adr/README.md` に、layat の ADR 番号・型の区分・実データと同じ文書に書かれていた。 (deprecated)
* [提案を棄却した決定は status 不採用 で記録する](./adr-status-rejected.md) - ADR の `status` は、実データの表記に合わせて日本語の値を持つ enum にしている。組み込みの英語の値（`proposed` / `accepted` / `deprecated`）は使っていない。 (deprecated)
* [ADR も UUID で採番し、連番の旧 ADR は legacy_adr 型に凍結する](./adr-uuid-ids-and-legacy-type.md) - ADR だけは連番（`ADR-NNNN`）で採番してきた。既存 ADR の相互参照やコミットメッセージでの言及を無効にしないためである。一方、並列レーンで ADR を起こすと、複数のレーンが同じ「次の番号」を取る構造が残っていた。 (deprecated)
* [フル ID は frontmatter と H1 見出しだけに書き、item にはリンクで触れる](./full-ids-in-frontmatter-and-h1.md) - フル ID の書き場所を frontmatter と H1 見出しに限り、`specification` などの文字列でも item へは Markdown リンクで触れ、ファイル名は `<slug>.md` にする。 (deprecated)
* [ID はフル UUID に統一し 8 文字省略形を使わない](./full-uuid-ids-no-short-form.md) - item の正式 ID はフル UUIDv4 だが、ファイル名と散文中の参照には前方 8 文字の省略形を使っていた。フル UUID は人が読めないという前提への対処だった。 (deprecated)
* [自動検証の形骸化は守備対象の impact を継承する](./gate-risk-inherits-impact.md) - 自動検証が気づかれないまま形骸化する risk（テストは緑なのに何も確認していない類）は、その自動検証自身が開発の中で完結する。`impact` を回復可能性で採点し（[risk の impact を検出後の回復可能性で採点する](risk-impact-as-recoverability.md)）、沈黙性を軸から外す（[沈黙性を risk のスコア軸にせず本文に書く](silence-not-a-score-axis.md)）と、この類型はそのまま読めば low になる。 (deprecated)
* [level が high の risk に人の verified を求める](./human-verified-required-for-high-risk.md) - level が high の risk 自身に、generated.at 以降の human: の verified を求め、medium・low の risk と TC・CASE には求めない (deprecated)
* [ID の書き場所と省略形の禁止は起票の機械化と契約テストで担保する](./id-placement-enforced-by-contract-test.md) - フル ID の書き場所と 8 文字省略形の禁止を、起票ラッパーによる機械化と契約テスト link-text.sh の検出で担保する。 (deprecated)
* [index.md の節は item の section から生成する](./index-sections-from-item-section.md) - requirement・design・ubiquitous_term の index.md は、item が持つ必須の enum フィールド section ごとに節を分けて生成し、見出しと並び順は生成スクリプトの表に置く (deprecated)
* [概要文書は item へのリンク集に縮退させる](./overview-docs-as-link-index.md) - [ドキュメントは sara のナレッジグラフとして item に分割する](docs-as-sara-knowledge-graph.md) と決めたので、`docs/spec.md`・`docs/design.md`・`docs/concept.md` の規範的な内容は item へ移る。元の 3 文書をどう扱うかを決める必要があった。 (deprecated)
* [root は solution と ADR 系の型だけにする](./roots-solution-and-adr-types-only.md) - sara の接続漏れの判定は、item が `direction: upstream` の relation を実際に 1 本でも張っているかだけで決まる。型単位・item 単位で接続漏れの warning を抑止する設定は無い。 (deprecated)
* [sara 品質管理機構の決定は sara_adr 型に分ける](./sara-adr-type-for-doc-process-decisions.md) - `docs/adr/` には、layat 本体の設計判断と、sara による品質管理機構（`docs/model.yaml`・グラフの検証・起票ラッパー・item の運用規約）の設計判断が混在していた。後者は layat に固有ではなく、#500 で別のリポジトリへ切り出す予定がある。 (deprecated)
* [sara-id を廃止し sara init を包む起票ラッパーを使う](./sara-new-wrapper-replaces-sara-id.md) - `sara-id` は devShell 同梱の採番コマンドで、UUIDv4 の採番・8 文字の重複の確認・省略形の出力・型名からprefix への写像・ファイル名素材の組み立てを担っていた。item ファイルの作成は `sara init` が担当した。 (deprecated)
* [省略形の禁止は起票の機械化と全面移行で担保する](./short-form-ban-enforced-by-tooling.md) - 8 文字の省略形を使わないという規則は [ID はフル UUID に統一し 8 文字省略形を使わない](full-uuid-ids-no-short-form.md) が決めた。本 ADR は、その禁止をどう担保するかだけを決める。担保の方法は、禁止の規則を変えずに単独で覆せる。後から CI の検出を入れるなら、本 ADR だけを廃止すればよい。そのため規則とは別の ADR にする。 (deprecated)
* [item のファイル名は slug だけにする](./slug-only-filenames.md) - item のファイル名を `<slug>.md` にし、フル ID は frontmatter と H1 見出しだけに書き、散文は Markdown リンクで item を参照する。 (deprecated)
* [テスト系 item を CASE・TC・RISK の 3 段で起こし、概要文書へ索引しない](./test-items-three-tier-granularity.md) - CASE はテスト資産、TC は検証テーマ、RISK は TC を束ねる脅威の単位で起こし、概要文書へ索引しない。 (deprecated)
* [用語を ubiquitous_term の item で管理する](./ubiquitous-term-type.md) - 用語の正名・避ける綴り・定義は、`CONTEXT.md`（日本語の長い定義）と `docs/glossary.md` / `docs/glossary.ja.md`（英日の短い定義）の 3 ファイルが重ねて持っていた。3 ファイルの同期は手作業で、語の数も定義の中身もすでに食い違っている。用語を 2 語足すだけで 5 ファイルを直す必要があった（#644）。 (deprecated)

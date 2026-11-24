# 品質（`quality`）

* [設計判断は ADR に記録し、改訂の書き戻しと item への接続を同じ変更の中で完了させる](./adr-decisions-recorded-and-connected.md) - 決定を記録しない、あるいは記録したが後続の改訂で一部だけが古くなった ADR を有効なまま残す状態は、その ADR だけを読んだ人に「上書きされた内容」を最新仕様と誤読させる。本 item はその防止を規範として固定する。
* [ADR は 1 本に 1 つの決定を 4 節で書き、justifies は規範の形成に寄与した item へ張る](./adr-one-decision-four-sections-justifies-by-contribution.md) - ADR は単独で覆せる決定ごとに 1 本を 4 節で書き、justifies は規範の形成に寄与した item へ張る
* [カバレッジは報告にとどめ、閾値でマージを止めない](./coverage-reported-without-threshold.md) - カバレッジは報告にとどめ、閾値でマージを止めないと定める。
* [欠陥はトラッカーが持ちドキュメントグラフは規範のみを持つ。起票は分類語彙を経由する](./defects-in-tracker-graph-holds-norms.md) - グラフが持つのは「そうあるべき姿」であり、欠陥は「起きた出来事」になる。両者を同じ場所に置くと、規範の集合に時系列の記録が紛れ、規範だけを読みたい参照が汚れる。所在をトラッカーとグラフで分ける。
* [ドキュメントグラフのトレーサビリティは機械的に検証する](./document-graph-mechanically-verified.md) - 文書間の参照が指す先を失う、というずれ方は「気づいた人が直す」運用では検出できない。存在しない ID への参照・ID の重複・循環は、人が読んで気づく類の誤りではないため、機械検証に置く。
* [rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする](./formatting-and-static-analysis-before-merge.md) - 整形の rustfmt と静的解析の clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにすると定める。
* [フル ID は frontmatter だけに書き、散文では item にリンクで触れる](./full-ids-in-frontmatter-links-in-prose.md) - ID はフル UUIDv4 で frontmatter だけに書き、ファイル名は slug とし、散文では name を文字列にしたリンクで item に触れる
* [用語の正名は用語 item が固定し、執筆はそれに従う](./glossary-fixes-canonical-terms.md) - 同じ概念が箇所ごとに違う語で呼ばれると、読み手は同じものを指しているのか判断できず、検索も当たらなくなる。正名を 1 箇所で固定し、執筆はそこに従う。
* [level が high の risk と、有効な solution と use_case は人が確かめた記録を持つ](./high-risk-verified-by-human.md) - level が high の risk と、status が deprecated でない solution と use_case は、generated.at 以降に人が内容を確かめた verified を持つ
* [人が最終的に判断する test_condition は、human_judgement に理由を書いて一覧にする](./human-judgement-marked-on-test-condition.md) - test_condition は機械で確かめるのを既定にし、人が最終的に判断するものだけが human_judgement に理由の 1 文を持ち、それを情報として一覧にする。
* [main は PR だけで変え、required の check が成功するまでマージしない](./main-changed-only-by-pull-request-with-required-checks.md) - main は PR だけで変え、required の check が成功するまでマージせず、直接の push、削除、force push を禁じると定める。
* [規範の型は、それが誰を縛るかで決める](./norm-type-by-who-it-binds.md) - 規範の型は、それが誰を縛るかで requirement・quality・test_plan から選ぶ
* [規範は 1 ファイル 1 item のグラフが持ち、item の一覧は生成した index.md だけが持つ](./normative-items-placement-and-authoring.md) - 規範を手書きの文書と item の両方に書くと二重管理になり、改訂で片方だけが古くなる。規範の所在をグラフ側に一本化し、型ごとの item の一覧はグラフから生成した index.md が持つ。各ディレクトリの手書きの README.md は、item から導けない全体像の散文だけを持つ。この分担は文書の分量ではなく**どちらを正とするか**の宣言であり、README.md へ仕様や item の一覧を書き足すことは規範の複製にあたる。
* [文書管理の規範と決定は mitodoke のリポジトリで変える](./norms-and-decisions-changed-in-mitodoke.md) - 写した時点から、文書管理の規範と決定を mitodoke のリポジトリだけで変えることを定める。
* [mitodoke の文書は mitodoke 自身で管理する](./own-docs-managed-by-mitodoke.md) - mitodoke のリポジトリは自身の文書を mitodoke で管理し、文書管理の規範を quality item、文書管理の決定を adr として持つ
* [プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる](./platform-dependent-layers-verified-on-all-platforms.md) - プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させると定める。
* [solution の確認の問い](./review-questions-for-solution.md) - solution に人の確認を記録する前に人が答える、3 つの確認の問い。
* [use_case の確認の問い](./review-questions-for-use-case.md) - use_case に人の確認を記録する前に人が答える、3 つの確認の問い。
* [risk はまず requirement に張り、設計を差し替えると消える懸念だけを design に張る](./risk-attaches-to-requirement-by-default.md) - risk はまず requirement に張り、設計を差し替えると消える懸念だけを design に張る
* [risk は ISO/IEC 25010:2023 の品質特性を 1 つ持ち、リスクを持たない特性は対象外の宣言を除いて列挙する](./risk-carries-one-quality-characteristic.md) - risk は ISO/IEC 25010:2023 の 9 つの品質特性から 1 つを quality_characteristic に持ち、有効な risk を持たない特性は、理由付きの対象外の宣言を除いて機械的に列挙する。
* [risk の level は likelihood と impact から導き、手で決めない](./risk-level-derived-from-likelihood-and-impact.md) - risk の likelihood と impact を決まった尺度で採点し、level はその 2 つから導く
* [sara は必要なときに上げ、組み込む版と配る版を同じタグに揃える](./sara-version-upgrade-policy.md) - sara のタグを上げる時機と、上げるときに組み込む版と配る版を同じタグに揃えて確かめる手順を定める。
* [specification は SHALL 系で書き、日本語の規範文は同じ強度の規範助動詞で終える](./specification-shall-family-and-matching-auxiliaries.md) - specification は SHALL 系で書き、specification_ja は同じ強度の規範助動詞で終える
* [上流より古い item と generated の更新漏れは機械的に列挙する](./stale-items-enumerated-mechanically.md) - 上流より基準時刻が古い下流の item、本文を変えたのに generated を更新していない item、stale_after の期限切れと間隔の超過を機械的に列挙し、結果は報告に留める
* [テスト系 item は、テスト資産・検証テーマ・脅威の 3 段の粒度で起こす](./test-items-three-tier-granularity.md) - テスト系 item は CASE をテスト資産・TC を検証テーマ・RISK を脅威の単位で起こし、人が行うテストも CASE にする
* [バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る](./version-from-single-source-with-automated-tags.md) - mitodoke のバージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作ると定める。
* [workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する](./workflows-least-privilege-and-pinned-actions.md) - workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定すると定める。

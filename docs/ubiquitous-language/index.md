# 用語（`ubiquitous_term`）

## モデルの型

* [adr](./adr.md) - 1 つの意思決定とその背景・根拠を記録するモデルの型。
* [built-in type（組み込みの型）](./built-in-type.md) - どの製品のモデルにも最初から含まれる 12 の型の 1 つ。
* [custom type（独自の型）](./custom-type.md) - 製品が、組み込みの型に加えて、設定でモデルに足す型。
* [design（設計）](./design.md) - 要件をどう実現するかを述べるモデルの型。
* [infrastructure（基盤）](./infrastructure.md) - 製品の開発・提供・稼働を支える技術基盤を述べるモデルの型。
* [quality（品質）](./quality.md) - テストの工程の外にある、開発の進め方を縛る方針と規約を述べるモデルの型。
* [requirement（要件）](./requirement.md) - 要求に応えるために製品が満たす条件を述べるモデルの型。
* [risk（リスク）](./risk.md) - 要件や設計が満たされなくなる懸念を、脅威ごとに述べるモデルの型。
* [solution（解決策）](./solution.md) - リポジトリが作る製品が何であるかを述べるモデルの型。
* [test_case（テストケース）](./test-case.md) - 単独で実行できるテスト 1 つを表すモデルの型。
* [test_condition（テスト条件）](./test-condition.md) - リスクを減らすためにテストが検証するテーマ 1 つを表すモデルの型。
* [test_plan（テスト計画）](./test-plan.md) - テスト計画の活動で決めたことを述べるモデルの型。
* [ubiquitous_term（用語）](./ubiquitous-term.md) - 用語 1 語の正名と避ける綴りを固定するモデルの型。
* [use_case（要求）](./use-case.md) - 利用者が製品で何をしたいかを述べるモデルの型。

## グラフと item

* [artifact（成果物）](./artifact.md) - 品質について人間が検討・判断した結果として書き残すもの。
* [document graph（ドキュメントグラフ）](./document-graph.md) - item を節、relation を辺とし、参照の正しさを機械的に検証するグラフ。
* [downstream（下流）](./downstream.md) - ある item を向きが上流の relation で指し、その内容を前提にしている item。
* [full ID（フル ID）](./full-id.md) - `<PREFIX>-<フル UUIDv4>` の形で item を一意に指す ID。
* [item](./item.md) - ドキュメントグラフを構成する、frontmatter を持つ Markdown ファイル 1 つ。
* [norm（規範）](./norm.md) - 何かを縛る規則を述べる、requirement・quality・test_plan の item の総称。
* [orphan（接続漏れ）](./orphan.md) - 上流の item にぶら下がるべきなのに、向きが上流の relation を 1 本も張っていない item の状態。
* [relation](./relation.md) - item が frontmatter で別の item を指して張る、種類の付いた辺。
* [upstream（上流）](./upstream.md) - ある item が向きが上流の relation で指し、前提にしている item。

## 鮮度と確認

* [generated](./generated.md) - item を最後に生成・更新した者と時刻を記録する frontmatter のプロパティ。
* [human verification（人の確認）](./human-verification.md) - 人が item の内容を確かめたことの記録で、`verified` の要素のうち、`by` が `human:` で始まり、`at` がその item の `generated.at` 以降のもの。
* [reference time（基準時刻）](./reference-time.md) - item の鮮度を比べる基準にする、generated と verified から決まる時刻。
* [stale（再確認待ち）](./stale.md) - 上流の item が自身の基準時刻より新しくなり、読み直しを待っている item の状態。
* [verified](./verified.md) - item の内容を誰がいつ確認したかを、要素ごとに記録する frontmatter のプロパティ。

## 検査の結果

* [inspection strength（検査の強さ）](./inspection-strength.md) - 検査の指摘をどう扱うかを決める設定の値。
* [missing connection（つながりの欠け）](./missing-connection.md) - 検査の 3 つの分類の 1 つで、検証へ向かう連鎖が期待する relation を欠いた item を見つけるもの。
* [reach rate（到達率）](./reach-rate.md) - ある型の item のうち、下流の連鎖が末端までつながっているものの割合。
* [review obligation（見直しの義務）](./review-obligation.md) - 検査の 3 つの分類の 1 つで、人が読み直すか確かめるかをまだ済ませていない item を見つけるもの。
* [silence（沈黙性）](./silence.md) - 脅威が起きたときに、それに気付けるかどうかという性質。
* [structural contract（構造の契約）](./structural-contract.md) - 検査の 3 つの分類の 1 つで、item とドキュメントグラフの形が整っているかを確かめるもの。
* [test asset（テスト資産）](./test-asset.md) - テストケースが対応する、単独で実行できるテストの単位。
* [uncovered（未カバー）](./uncovered.md) - 検証へ向かう連鎖が期待するつながりを欠いている item の状態。

## 適用先の製品と人

* [product（製品）](./product.md) - 規範を当てはめるリポジトリが作るもの。
* [test category（テストの区分）](./test-category.md) - 製品のテストを分ける単位で、製品が自分で、設定の 1 つの一覧として決めるもの。
* [user（利用者）](./user.md) - 製品を使う人。

---
id: "QA-83707ee2-5937-405d-ba7c-2d19109155d0"
type: quality
name: "規範の型は、それが誰を縛るかで決める"
description: "規範の型は、それが誰を縛るかで requirement・quality・test_plan から選ぶ"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
specification: |
  A norm that binds the product's behaviour and contracts as a user meets them SHALL be
  placed in a `requirement`; a norm that binds the development process, conventions and
  governance SHALL be placed in a `quality`; a norm that binds the scope, levels and
  approach of testing SHALL be placed in a `test_plan`. Between the two types under the
  `solution`, the `test_plan` question SHALL be asked first: an item that exists because
  something has to be verified SHALL be a `test_plan`, and `quality` SHALL take what
  remains. Between `quality` and `infrastructure`, the norm itself SHALL be held by a
  `quality`, and the machinery that upholds it SHALL be held by an `infrastructure`.
specification_ja: |
  製品の振る舞いと契約を利用者から見える形で縛る規範は `requirement` に置かなければならず、
  開発の進め方・規約・ガバナンスを縛る規範は `quality` に置かなければならず、テストの範囲・
  レベル・方法を縛る規範は `test_plan` に置かなければならない。`solution` 直下の 2 型の間では
  `test_plan` の問いを先に当てなければならない。何かを検証する必要があるから存在する item は
  `test_plan` としなければならず、残りを `quality` としなければならない。`quality` と
  `infrastructure` の間では、規範そのものは `quality` が持たなければならず、それを支える仕組みは
  `infrastructure` が持たなければならない。
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-20T00:06:59+09:00"
---
# 規範の型は、それが誰を縛るかで決める

## 仕様

`specification` / `specification_ja` の組を持ち、グラフの仕様側にぶら下がる型は 3 つある。
`use_case` の下の `requirement`、`solution` の下の `quality` と `test_plan` である。この 3 型を
機械的に見分ける仕組みは無い。形さえ正しければ誤った親も正しい親と区別が付かないので、誤った
型に置いた item も `sara check` を通る。RFC2119 キーワードの検査も助けにならない。キーワードの
有無は、空でない `specification` を持つ item なら型を問わず確認される。したがって型の選択は
判断であり、次の規則で決め、レビューだけで守る。

> その規範が**誰を縛るか**を問う。利用者が出会う製品を縛る規範は `requirement`、製品を作る
> 人と進め方を縛る規範は `quality`、何をどうテストするかを縛る規範は `test_plan` とする。

型ごとの判別は次のとおり。

| 型 | 規範が縛るもの | 親 | 判定の問い |
|---|---|---|---|
| `requirement` | 製品の振る舞いと契約。このリポジトリを読まない利用者にも観測できる。 | `use_case` | 外すと、製品の何らかの*使い方*が変わる。 |
| `quality` | 開発の進め方・規約・ガバナンス。機能に付くのではなく作業を横断し、それ自体は何かの検証を目的としない。 | `solution` | 外しても気付くのは開発者だけで、出荷物は変わらず、失われる検証も無い。 |
| `test_plan` | テストの範囲・レベル・方法。テスト対象へ手が届くようにすることを含む。 | `solution` | そもそも存在する理由が、何かを検証しなければならないことにある。 |

`solution` 直下の 2 型は開発者の問いで重なる。どちらを外しても利用者には見えない。そこで
`test_plan` の問いを先に当てる。何かを検証する必要があるから存在する item は `test_plan` で、
残りが `quality` になる。

例: 製品が返す結果の意味（CLI の終了コード、API の応答の状態など）、外へ公開するデータ形式の
構成、矛盾する入力を受けたら処理を止めることは `requirement`。「`specification` は英語で書く」
「CI で対象の全プラットフォームの検査を回す」は `quality`。テスト環境の範囲、*テストの*対象外と
する宣言、テストできるようにする手当ては `test_plan`。

### 判別に迷う場合

ほとんどの item は上の規則だけで決まる。迷うのは、規範の見かけと、それが縛る相手が食い違う
ときである。そのときは見かけではなく、判定の問いで決める。

- 進め方の規則に見えても、外すと利用者の使い方が変わる規範は `requirement` にする。依存の制約、
  出力の形式や出力先、公開するデータ形式の版、製品が動くために利用者の環境が満たす前提条件が
  これにあたる。どれも利用者が直接出会う境界を縛る。同じ主題でも、製品が出力・受理するものを
  変えずに開発者の作業だけを縛る規範（いつ版を上げてよいか、リポジトリ全体の書き方、この
  リポジトリ自身の CI の義務）は `quality` になる
- 何かを対象外とする宣言は、*誰の*範囲を区切るかで決める。製品が何かを提供しないという宣言は
  `requirement` にする。利用者ができることの範囲を区切り、利用者はその欠落に直接出会うからで
  ある。何かを*検証しない*という宣言は `test_plan` にする。製品はその機能を提供したままで、
  テストがそこまで届かないだけだからである
- 製品が公開する面でも、テストを内部の実装へ届かせるためだけに存在し、安定性と後方互換の保証を
  負わない面は `test_plan` にする。契約に見えるが、存在する理由は検証にある

### `quality` と `infrastructure` の区別

`quality` は規範を持ち、`infrastructure` はそれを支える仕組みを持つ。「マージ前に対象の
全プラットフォームで検査が通る」は `quality`、それを回す CI パイプラインは `infrastructure` で
ある。迷ったら、ツールを差し替えてもその item が成り立つかを問う。成り立つなら規範である。

## 出典

[テスト計画の型を品質方針の型から分けて設ける](../adr/quality-and-test-plan-types.md) と
[infrastructure を技術基盤として再定義し root から外す](../adr/infrastructure-redefined-non-root.md) が置いた型の区分を、Issue #240 で判別の規則として
定め、灰色領域の先例（Issue #239 の決着を含む）とともに運用してきたもの。Issue #649 で
quality item として立てた。

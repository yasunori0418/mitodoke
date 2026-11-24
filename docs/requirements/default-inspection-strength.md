---
id: "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
type: requirement
name: "検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は報告とし、どの検査の強さも設定で変えられるようにする。"
specification: |
  By default, a violation of a structural contract SHALL be a failure. The structural
  contracts SHALL be the following: `sara check` (including a `solution` lacking
  `stale_after`), the shape of the frontmatter, the placement of IDs, the one-to-one
  correspondence between test_case items and test assets, the derivation of a risk's `level`,
  the `deprecated` status of a `supersedes` target, the difference in `index.md`, the `covers`
  and `follows` of a test_case, an undeclared frontmatter key, the shape and the values of the
  OKF keys, the constraints on top of OKF that are inspected as structural contracts, the match between a type and its location, and a
  duplicated test asset. By default, a connection gap and a review obligation SHALL be reported
  without failing. The connection gaps SHALL be the following: a test_condition that is not
  covered, a risk that is not mitigated, a requirement that is not threatened, a quality that is
  not satisfied, an active use_case without an active requirement, an active requirement all of whose
  parent use_case items are deprecated, and a quality characteristic without an active risk. The
  review obligations SHALL be the following: an item awaiting review after an upstream change, a
  missing `generated` update (an item whose body changed in the difference from the base revision
  while `generated.at` did not change), a high risk lacking a human verification, an active
  solution or use_case lacking a human verification, an expired `stale_after`, and a
  `stale_after` beyond its interval. An active item SHALL be an item whose `status` is not
  `deprecated`, `draft` included. In every section, gap and fresh SHALL count only active items,
  and SHALL count an edge only when both of its ends are active items. The structural contracts
  of check SHALL apply also to items whose `status` is `deprecated`. The strength of every
  inspection SHALL be changeable in the configuration.
  In the missing `generated` update, the body SHALL be the lines outside the frontmatter together
  with `specification` and `specification_<language>` in the frontmatter, and a change of `name`,
  `description`, `status`, a relation or an OKF key SHALL NOT count as a change of the body. When
  only the notation of `generated.at` is rewritten and it points to the same instant, the
  inspection SHALL regard `generated.at` as not changed. In a
  run given no base revision, mitodoke SHALL NOT perform the inspection of missing `generated`
  updates, and check and fresh SHALL record in the result that the inspection was not performed.

  A file that the sara-core loader skips (a scan warning) and a model that cannot be read SHALL
  be treated as preconditions of loading, not as inspections, and SHALL NOT be subject to the
  strength setting. When a file is skipped, check SHALL represent the skipped file as a failed item
  with a dedicated code and SHALL end with exit code 1, and SHALL NOT classify the skip into the
  structural contracts, the connection gaps or the review obligations. When a file is skipped, the
  other subcommands that load the document graph (new, index, gap, fresh, matrix, verify and
  export) SHALL NOT start processing and SHALL end with exit code 2 as an input error, and new and
  verify SHALL refuse to write. When the model cannot be read or the installation of the model
  fails, check and the subcommands that load the document graph SHALL end with exit code 2 and
  SHALL NOT fall back to the built-in types. init and model SHALL NOT be subject to these rules.
  Having zero items SHALL NOT in itself be an error or a finding, and mitodoke SHALL NOT end a
  run with a non-zero exit code only because it has zero items.
specification_ja: |
  既定では、構造の契約の違反は失敗としなければならない。構造の契約は、
  `sara check`（`solution` の `stale_after` の欠けを含む）、frontmatter の形、ID の置き場所、test_case と
  テスト資産の 1:1、risk の `level` の導出、`supersedes` の先が `deprecated` であること、`index.md` の差分、
  test_case の `covers` と `follows`、宣言の無い frontmatter のキー、OKF のキーの形と値、OKF に重ねる制約の
  うち構造の契約として検査するもの、型と置き場所の一致、テスト資産の重複でなければならない。既定では、つながりの欠けと見直しの義務は、失敗にせずに報告
  しなければならない。つながりの欠けは、covers されない test_condition、
  mitigates されない risk、threatens されない requirement、satisfies されない quality、有効な requirement
  を持たない有効な use_case、親の use_case がすべて deprecated の有効な requirement、有効な risk を持たない
  品質特性でなければならない。見直しの義務は、上流の変更による再確認待ち、generated の更新
  漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）、人の確認が
  無い high の risk、人の確認が無い有効な solution と use_case、stale_after の期限切れ、stale_after の
  間隔の超過でなければならない。有効な item は、`status` が `deprecated` でない item（`draft` を含む）で
  なければならない。gap と fresh は、すべての節で有効な item だけを数えなければならず、辺は両端が有効な
  item のものだけを数えなければならない。check の構造の契約は、`status` が `deprecated` の item にも
  働かせなければならない。どの検査の強さも、設定で変えられなければならない。
  generated の更新漏れの本文は、frontmatter の外の行に、frontmatter の `specification` と
  `specification_<言語>` を加えたものでなければならず、`name`・`description`・`status`・relation・
  OKF のキーの変更は、本文の変更に数えてはならない。`generated.at` の表記だけを書き換えて同じ時刻を
  指しているときは、検査は `generated.at` が変わっていないとみなさなければならない。基準のリビジョンを渡さない実行では、mitodoke は
  generated の更新漏れの検査をしてはならず、check と fresh は、検査しなかったことを結果に記録しなければ
  ならない。

  sara-core の読み込みが読み飛ばしたファイル（scan warning）と、モデルを読めないことは、検査ではなく
  読み込みの前提として扱わなければならず、強さの設定の対象にしてはならない。ファイルが読み飛ばされた
  とき、check は、読み飛ばされたファイルを専用のコードを付けた failed の item で表して exit code 1 で
  終わらなければならず、読み飛ばしを構造の契約・つながりの欠け・見直しの義務のどれにも入れてはならない。
  ファイルが読み飛ばされたとき、ドキュメントグラフを読み込むほかのサブコマンド（new・index・gap・fresh・
  matrix・verify・export）は、処理を始めずに入力の誤りとして exit code 2 で終わらなければならず、new と
  verify は書き込みを拒まなければならない。モデルを読めないときと、モデルの install が失敗したときは、
  check とドキュメントグラフを読み込むサブコマンドは exit code 2 で終わらなければならず、組み込みの型へ
  戻ってはならない。init と model は、これらの規則の対象にしてはならない。item が 0 件であること自体を、
  誤りにも該当にもしてはならず、mitodoke は、item が 0 件である
  ことだけを理由に、exit code を 0 以外にしてはならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T20:22:00+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-23T13:44:02+09:00"
  - by: "human:yasunori0418"
    at: "2026-11-24T23:50:15+09:00"
---
# 検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる

## 仕様

mitodoke の検査は、構造の契約、つながりの欠け、見直しの義務の 3 つに分かれる。既定では、
構造の契約の違反だけを失敗にし、つながりの欠けと見直しの義務は CI で報告する。

構造の契約は次のものとする。

- `sara check`（`solution` の `stale_after` の欠けを含む）
- frontmatter の形
- ID の置き場所
- test_case とテスト資産の 1:1
- risk の `level` の導出
- `supersedes` の先が `deprecated` であること
- `index.md` の差分
- test_case の `covers` と `follows`
- 宣言の無い frontmatter のキー
- OKF のキーの形と値
- OKF に重ねる制約のうち構造の契約として検査するもの
- 型と置き場所の一致
- テスト資産の重複

つながりの欠けは次のものとする。

- covers されない test_condition
- mitigates されない risk
- threatens されない requirement
- satisfies されない quality
- 有効な requirement を持たない有効な use_case
- 親の use_case がすべて deprecated の有効な requirement
- 有効な risk を持たない品質特性

見直しの義務は次のものとする。

- 上流の変更による再確認待ち
- generated の更新漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）
- 人の確認が無い high の risk
- 人の確認が無い有効な solution と use_case
- stale_after の期限切れ
- stale_after の間隔の超過

generated の更新漏れの本文は、frontmatter の外の行に、frontmatter の `specification` と
`specification_<言語>` を加えたものとする。`name`・`description`・`status`・relation・OKF のキーの変更は、
本文の変更に数えない。`generated.at` の表記だけを書き換えて同じ時刻を指しているときは、`generated.at` が
変わっていないとみなす。基準のリビジョンを渡さない実行では、generated の更新漏れの検査をしない。`check` と
`fresh` は、検査しなかったことを結果に記録する。frontmatter の外の行の比較で除く行（今の規則は
[generated の更新漏れの検査は、frontmatter の specification も本文に数える](../adr/generated-update-check-includes-specification.md)
にある）を固定にするか設定から導くかは、再確認と人の確認の epic が決め、この要件では定めない。

`human_judgement` を持つ test_condition の一覧は、人が判断する範囲を示す情報で、3 つの分類のどれにも
当たらない。

### 有効な item

[有効な item](../ubiquitous-language/active-item.md) は、`status` が `deprecated` でない item を指し、
`draft` を含む。この要件の列挙の「有効な」も、この意味である。

- `gap` と `fresh` は、すべての節で有効な item だけを数える。辺は、両端が有効な item のものだけを数える。
  たとえば、`deprecated` の risk からの `threatens` は、requirement を覆ったことにしない
- `check` の構造の契約は、`status` が `deprecated` の item にも働かせる

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、適用先の製品が決める。

### 読めない入力

sara-core の読み込みが読み飛ばしたファイル（scan warning）と、モデルを読めないことは、検査ではなく
読み込みの前提として扱う。前提は強さの設定の対象にしない。

- ファイルが読み飛ばされたとき、`check` は、読み飛ばされたファイルを専用のコードを付けた `failed` の
  item で表し、exit code 1 で終わる。読み飛ばしは、構造の契約・つながりの欠け・見直しの義務のどれにも
  入れない
- ファイルが読み飛ばされたとき、ドキュメントグラフを読み込むほかのサブコマンド（`new`・`index`・`gap`・
  `fresh`・`matrix`・`verify`・`export`）は、処理を始めずに、入力の誤りとして exit code 2 で終わる。
  `new` と `verify` も書き込みを拒む
- モデルを読めないときと、モデルの install が失敗したときは、`check` とドキュメントグラフを読み込む
  サブコマンドが exit code 2 で終わり、組み込みの型へ戻らない
- `init` と `model` はグラフを読まないので、これらの規則の対象にしない
- item が 0 件であること自体は、誤りにも該当にもしない。item が 0 件であることだけを理由に、exit code を 0 以外にしない

## 出典

根拠の決定は次の ADR が持つ。

- [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にし、それぞれの列挙を閉じる](../adr/default-strength-with-closed-lists.md)
- [読み飛ばしは check を失敗させ、グラフを読むほかのサブコマンドを止める](../adr/scan-skips-fail-check-and-block-graph-commands.md)
- [有効な item だけを gap と fresh で数え、辺は両端が有効なものだけを数える](../adr/active-items-and-edges-counted-in-gap-and-fresh.md)
- [generated の更新漏れの検査は、frontmatter の specification も本文に数える](../adr/generated-update-check-includes-specification.md)
- [モデルを読めなければ exit 2 で終え、組み込みの型へ戻らない](../adr/unreadable-model-exits-without-builtin-fallback.md)
- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)

新しく足した検査の要件は次の item が持つ。

- [gap は、要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を報告し、人が判断するテスト条件を一覧にする](gap-reports-upstream-and-quality-characteristic-gaps.md)
- [fresh は、人の確認の無い solution と use_case、期限切れ、期限の間隔の超過を報告する](fresh-reports-unverified-validation-and-expiry.md)
- [test_case は covers と follows をそれぞれ 1 本以上持たなければならない](test-case-link-contract.md)
- [宣言の無い frontmatter のキーは構造の契約の違反とする](undeclared-frontmatter-keys.md)
- [OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する](okf-key-inspection.md)
- [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](constraints-on-top-of-okf.md)
- [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](type-locations-in-config.md)
- [テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](test-asset-inventory-sources.md)

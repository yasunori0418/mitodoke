---
id: "ADR-4209761c-9d82-4f6c-ac1b-206558491425"
type: adr
name: "構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にし、それぞれの列挙を閉じる"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は CI での報告とし、3 つの分類に当たる検査を閉じた列挙で決め、どの検査も設定で強さを変えられるようにする。"
section: inspection
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "issue #72 の grilling（2026-11-22）で確定。構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする ADR を書き直した"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
supersedes:
  - "ADR-7f1ac4f7-75b3-4837-9825-025a23f1673b"
references:
  - "ADR-bf25a81b-d588-4c7e-9365-fe514ee4d626"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:38:16+09:00"
---
# 構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にし、それぞれの列挙を閉じる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする](default-strength-fail-structure-report-gaps.md), [sara check を strict モードで回す](sara-check-strict-mode.md), GitHub Issue #72, GitHub Issue #4
- 起点: issue #72 の grilling（2026-11-22）で確定。構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする ADR を書き直した

## 背景

mitodoke の検査には、item の構造が契約に合っているかを見るもの、relation の欠けを見るもの、
上流の変更などで人が見直すべき item を見るものがある。どれを失敗にし、どれを報告に留めるかの
既定を、製品として決める必要がある。

写した script の運用では、`sara check`（strict）と独自の検査が CI の job を失敗させ、
`sara-fresh` は報告だけを出す。`sara-gap` は CI で実グラフに当てておらず、手で実行したときだけ
該当ありを exit 1 で返す。

コンセプト文書は、機械は特定して報告し、人間が評価して判断すると書く（§4.2）。また、
test_condition は検討すべき観点で、必ず実行することを意味しないと書く（§5.1・§5.2）。

既定の強さを決めた時点の列挙は「〜が当たる」と例を挙げる形で、閉じていなかった。そのあとに、ほかの要件が
構造の契約として検査すると定めたもの（`test_case` の `covers` と `follows`、宣言の無い frontmatter のキー、
OKF のキーの形と値、OKF に重ねる制約、型と置き場所の一致、テスト資産の重複）は、列挙に入っていなかった。
issue #80 では、つながりの欠けが 3 つと、見直しの義務が 3 つ加わった。

## 決定

検査の既定の強さを次のように分け、3 つの分類に当たる検査をそれぞれ次のものとする。

- 構造の契約は失敗にする。構造の契約は、`sara check`（`solution` の `stale_after` の欠けを含む）、
  frontmatter の形、ID の置き場所、test_case とテスト資産の 1:1、risk の level の導出、supersedes の先が
  deprecated であること、index.md の差分、`test_case` の `covers` と `follows`、宣言の無い frontmatter の
  キー、OKF のキーの形と値、OKF に重ねる制約のうち構造の契約として検査するもの、型と置き場所の一致、
  テスト資産の重複とする
- つながりの欠けは CI で報告する。つながりの欠けは、covers されない test_condition、mitigates されない
  risk、threatens されない requirement、satisfies されない quality、有効な requirement を持たない有効な
  use_case、親の use_case がすべて deprecated の有効な requirement、有効な risk を持たない品質特性とする
- 見直しの義務は CI で報告する。見直しの義務は、上流の変更による再確認待ち、generated の更新漏れ、人の
  確認が無い high の risk、人の確認が無い有効な solution と use_case、stale_after の期限切れ、
  stale_after の間隔の超過とする

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、mitodoke ではなく適用先の
製品が決める。

## 根拠

つながりの欠けを報告にすれば、CI を失敗させずに、毎回の CI で欠けを見えるようにできる。

つながりの欠けのうち、報告に留める根拠がコンセプトにあるのは test_condition の扱いだけである。
test_condition は必ず実行するものではないので、covers されない test_condition で CI を失敗させると
コンセプトと食い違う。mitigates されない risk、threatens されない requirement、satisfies されない
quality を報告にするのは、推奨した側の判断である。コンセプトはリスクから明示的なテスト条件が
導出されている状態を目指すと書いており（§3）、これらを失敗にする読み方もできる。その場合は、
設定で強さを上げられる。

列挙を閉じれば、ある検査の既定の強さを、列挙を読むだけで決められる。構造の契約に加える 6 つは、
それぞれの要件が構造の契約として検査するか、失敗にすると定めているもので、既定の強さの列挙と食い違わない
ようにする。

## 棄却した代替案

### 写した script の今の扱いのまま

`sara-gap` は CI で実グラフに当てず、手で実行したときだけ exit 1 の失敗にし、`sara-fresh` は報告に
する案。つながりの欠けが、手で実行したときにしか見えない。`sara-gap` をそのまま CI につなぐと、
covers されない test_condition が 1 件でもあれば CI が失敗し、test_condition を必須の実行としない
コンセプトと食い違う。

### すべての検査で失敗を既定にし、設定で緩める

covers されない test_condition で CI を失敗させると、test_condition を必須の実行としないコンセプトと
食い違うので採らなかった。

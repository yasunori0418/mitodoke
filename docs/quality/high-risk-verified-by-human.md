---
id: "QA-aa70fff6-3e0a-4163-bf4c-97f1730f7496"
type: quality
name: "level が high の risk と、有効な solution と use_case は人が確かめた記録を持つ"
description: "level が high の risk と、status が deprecated でない solution と use_case は、generated.at 以降に人が内容を確かめた verified を持つ"
specification: |
  A risk whose `level` is high, and a `solution` or `use_case` item whose `status` is not
  `deprecated`, SHALL carry at least one `verified` entry whose `by` begins with `human:`
  and whose `at` is at or after the item's `generated.at`. An entry by any other actor, or
  one dated before `generated.at`, SHALL NOT count. The requirement SHALL apply to these
  items themselves only, and an item whose `status` is `deprecated` SHALL be left out. An
  item lacking such an entry SHALL be enumerated mechanically, and the result SHALL be
  reported without gating merging. A `verified` entry SHALL NOT be added unless a person has
  read the item's content, and on a `solution` or `use_case` item it SHALL NOT be added
  unless the person has answered the review questions for its type.
specification_ja: |
  `level` が high の risk と、`status` が `deprecated` でない `solution` と `use_case` は、`by` が
  `human:` で始まり、`at` がその item の `generated.at` 以降である `verified` の要素を 1 つ以上
  持たなければならない。それ以外の actor の要素と、`generated.at` より前の要素は数えてはならない。
  この要求はこれらの item 自身にだけ当てなければならず、`status` が `deprecated` の item は除か
  なければならない。この要素を持たない item は機械的に列挙されなければならず、その結果は報告に
  留め、マージの条件にしてはならない。人が item の内容を読まないまま `verified` の要素を足しては
  ならず、`solution` と `use_case` では、型ごとの確認の問いに答えないまま足してはならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:14:11+09:00"
---
# level が high の risk と、有効な solution と use_case は人が確かめた記録を持つ

## 仕様

risk の `level` は likelihood と impact から導かれ（→ [risk の level は likelihood と impact から導き、手で決めない](risk-level-derived-from-likelihood-and-impact.md)）、
high は見立てを誤ったときの損失が最も大きい。本 item は high の risk について、エージェントが
書いたまま人が確かめていない状態を機械的に見分けられるようにする。

数えるのは、`by` が `human:` で始まり、`at` が `generated.at` 以降の `verified` だけになる。
`generated.at` より前の確認はその後に変わった本文を確かめていない。対象を high の risk 自身と、有効な solution と use_case（`status` が `deprecated` でないもの。`draft` を含む）に限る理由と、medium の risk や
test_condition・test_case に広げない理由は
[level が high の risk と、有効な solution と use_case に人の verified を求める](../adr/human-verified-required-for-high-risk-and-upper-layers.md) が持つ。

`solution` と `use_case` は保証する連鎖の上にあり、[確認の問い](../ubiquitous-language/review-question.md)に
人が答える[妥当性確認](../ubiquitous-language/validation.md)でカバーする。本 item は `status` が
`deprecated` でない `solution` と `use_case` についても、人が確かめていない状態を機械的に見分けられる
ようにする。`draft` の item も対象に含める。`solution` と `use_case` の人の確認は、
[solution の確認の問い](review-questions-for-solution.md)と[use_case の確認の問い](review-questions-for-use-case.md)に
答えてから記録する。

`verified` は自動では付けない。人が内容を確かめたときにだけ手で足す。

未達の item は列挙して報告に留め、マージの条件にしない。
未達の件数は、人が確かめるのを待っている item の数で、何かが破損したことを意味しない。

列挙の実装と CI での実行は infrastructure の item が持つ。

## 出典

この item は [layat の同じ slug の item](https://github.com/yasunori0418/layat/blob/97ec53ae73d8f609e7a7c53feeb1baf6909fd76d/docs/quality/high-risk-verified-by-human.md) を写し、製品の形態に依らない文面に
直したもの。layat での運用の経緯は、原本の出典が持つ。

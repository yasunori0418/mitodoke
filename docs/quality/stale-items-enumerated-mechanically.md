---
id: "QA-611977bd-3d11-4695-9fb2-a9f7211fcfbd"
type: quality
name: "上流より古い item と generated の更新漏れは機械的に列挙する"
description: "上流より基準時刻が古い下流の item、本文を変えたのに generated を更新していない item、stale_after の期限切れと間隔の超過を機械的に列挙し、結果は報告に留める"
specification: |
  The reference time of an item SHALL be the latest of its `generated.at` and every
  `verified[].at` that is at or after its `generated.at`, whatever the actor. An item that
  declares a `refines`, `derives_from`, `satisfies`, `threatens`, `mitigates`, `covers` or
  `follows` relation SHALL be enumerated as stale when the
  `generated.at` of the item it points to is later than its own reference time;
  `justifies` and the peer relations SHALL NOT take part, and an item whose `status` is
  `deprecated` SHALL be left out on either end. Comparing the merge base of a base
  revision and `HEAD` with the working tree, an item whose body changed while its
  `generated.at` did not SHALL be enumerated as missing a `generated` update. The body
  SHALL be the lines outside the frontmatter, with the H1 line starting with `# `, lines
  starting with `- ステータス:` and whitespace-only differences disregarded. An item added
  or deleted between the two sides SHALL NOT be compared, and a renamed item SHALL be
  compared with the content at its old path. An item whose `status` is not `deprecated` and
  whose `stale_after` is earlier than the current time SHALL be enumerated as expired, and
  it SHALL be cleared only when a person rewrites `stale_after` to a later time. For a type
  with a configured interval of N days, an item whose `status` is not `deprecated` and whose
  `stale_after` is later than its starting point plus N days SHALL be enumerated as beyond
  the interval. The starting point SHALL be the latest `verified[].at` whose `by` begins with
  `human:` and that is at or after `generated.at`, or `generated.at` when there is none. The
  interval of `solution` SHALL be 90 days. These enumerations SHALL be mechanical, and their
  results SHALL be reported without gating merging.
specification_ja: |
  item の基準時刻は、その item の `generated.at` と、`generated.at` 以降の `verified[].at`
  （actor を問わない）のうち最も新しい時刻でなければならない。`refines`・`derives_from`・
  `satisfies`・`threatens`・`mitigates`・`covers`・`follows` の relation を宣言している item は、
  指している item の `generated.at` が自身の基準時刻より新しいとき、再確認待ちとして列挙され
  なければならない。`justifies` と peer の relation は対象にしてはならず、`status` が
  `deprecated` の item は両端のどちらでも除かなければならない。`git merge-base <base> HEAD` の
  コミットと作業ツリーを比べ、本文が変わったのに `generated.at` が変わっていない item は、
  `generated` の更新漏れとして列挙されなければならない。本文は frontmatter の外の行とし、`# ` で
  始まる H1 の行、`- ステータス:` で始まる行、空白だけの差を除かなければならない。2 点の間で
  足した item と削除した item は比べてはならず、改名した item は旧パスの内容と比べなければ
  ならない。`status` が `deprecated` でなく、`stale_after` が現在時刻より前の item は、期限切れと
  して列挙されなければならず、期限切れは人が `stale_after` を先の時刻に書き換えたときにだけ
  解けなければならない。日数 N の間隔を決めた型では、`status` が `deprecated` でなく、
  `stale_after` が起点から N 日より先の item は、間隔の超過として列挙されなければならない。起点は
  `generated.at` 以降で `by` が `human:` で始まる `verified[].at` のうち最も新しい時刻とし、無ければ
  `generated.at` としなければならない。`solution` の間隔は 90 日でなければならない。これらの列挙は
  機械的に行わなければならず、その結果は報告に留め、マージの条件にしてはならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:31:16+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:10:32+09:00"
---
# 上流より古い item と generated の更新漏れは機械的に列挙する

## 仕様

sara の構造の検査は、型・relation・接続性が正しいかを見るが、上流の本文が変わったあとに下流が
古い前提のまま残っているかは見ない。本 item は `generated`・`verified`・`stale_after` を使って、
読み直しの要る item を 4 つの観点で列挙する。

再確認待ちは上流の relation を辿って鮮度を比べる。下流の item の基準時刻より上流の
`generated.at` が新しければ挙げる。辿る relation・基準時刻・除く item の理由は
[鮮度は上流の relation を辿って下流へ伝播させる](../adr/freshness-propagates-along-upstream-relations.md) が持つ。

`generated` の更新漏れは、base との差分で本文が変わったのに `generated.at` が変わっていない
item を挙げる。比べる 2 点は `git merge-base <base> HEAD` のコミットと作業ツリーで、本文は
frontmatter の外の行から H1 の行と `- ステータス:` の行を除いたものとし、空白だけの差は数えない。新しく足した
item と削除した item は比べず、改名した item は旧パスの内容と比べる。この範囲にした理由と、時刻を
比べない理由は [generated の更新漏れは PR の差分で確かめる](../adr/generated-update-checked-in-pr-diff.md) が持つ。

`stale_after` の時刻が現在時刻より前の有効な item（`status` が `deprecated` でないもの。`draft` を含む）は、[期限切れ](../ubiquitous-language/expired.md)として
列挙する。期限切れは上流の変更ではなく時間の経過だけで生じ、解けるのは人が `stale_after` を先の時刻に
書き換えたときだけである。

間隔の超過は、型ごとに決めた日数 N について、`stale_after` が起点から N 日より先にある有効な item を
挙げる。起点は `generated.at` 以降で最も新しい `human:` の `verified` の時刻で、無ければ `generated.at`
とする。期限を延ばすには、人の確認を記録してから `stale_after` を書き換える。確認を記録せずに書き換えると
起点が動かないので、間隔の超過に挙がる。`solution` の間隔は 90 日とし、型と日数の組は CLI の設定
ファイルができるまで `dev/tests/stale-after-intervals.tsv` に書く。`solution` に `stale_after` を必須に
する理由と、間隔と起点をこの形にした理由は
[solution に stale_after を必須にし、期限までの間隔を 90 日以内にする](../adr/solution-requires-stale-after-within-interval.md) が持つ。

どの列挙も、挙がったことは何かが破損したことを意味しない。上流を書き換えれば、下流の読み直しが
済むまで件数が増える。そのため結果は報告に留め、マージの条件にしない。
挙がった item をどう扱うかは人が判断する。件数を減らすために `verified` を足したり `generated.at` を
動かしたりしない。

列挙の実装と CI での実行は infrastructure の item が持つ。

## 出典

この item は [layat の同じ slug の item](https://github.com/yasunori0418/layat/blob/97ec53ae73d8f609e7a7c53feeb1baf6909fd76d/docs/quality/stale-items-enumerated-mechanically.md) を写し、製品の形態に依らない文面に
直したもの。layat での運用の経緯は、原本の出典が持つ。

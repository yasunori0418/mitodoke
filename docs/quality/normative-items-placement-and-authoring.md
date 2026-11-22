---
id: "QA-67715bb3-1162-4ccf-8441-2f44257a57da"
type: quality
name: "規範は 1 ファイル 1 item のグラフが持ち、item の一覧は生成した index.md だけが持つ"
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
specification: |
  Normative content SHALL be held by the item graph alone, one item per file. The list of
  items of each type SHALL be held only by the index.md generated from the graph, and a
  hand-written document SHALL NOT keep such a list or restate the norms of the items.
  Each item SHALL be placed under the type its norm binds, following the project's
  discrimination rule, and its identifier SHALL be drawn from the project's numbering
  command rather than assigned by hand, so that parallel lanes cannot collide on a number.
  An item whose type carries a specification SHALL state that norm in English and
  SHALL carry the corresponding Japanese norm alongside it; neither field SHALL be treated
  as a gloss of the other. A rejected proposal for a `use_case`, `requirement` or `design`
  item SHALL be kept with its `status` set to `deprecated`, under a title in the form of the
  proposal, with the rejection stated at the top of its body, and an item whose type carries
  a specification SHALL state the specification in the form of the proposal as well. A
  feature decided not to be built SHALL be recorded by setting its `use_case` to
  `deprecated` and supplementing the reason in prose.
specification_ja: |
  規範的な内容は 1 ファイル 1 item の item グラフだけが持たなければならない。型ごとの item の
  一覧は、グラフから生成した index.md だけが持たなければならず、手書きの文書はその一覧を持っては
  ならず、item の規範を書き写してもならない。
  各 item は、その規範が何を縛るかに応じてプロジェクトの型判別規約に従った型の下へ配置され
  なければならず、その識別子は手で振るのではなくプロジェクトの採番コマンドから採らなければ
  ならない（並列レーンで採番が衝突しないようにするため）。specification を持つ型の item は、
  その規範を英語で述べなければならず、対応する日本語の規範文を併記しなければならない。
  いずれの欄も他方の訳注として扱ってはならない。`use_case`・`requirement`・`design` で棄却した
  提案は、提案の形の題で `status` を `deprecated` にし、本文の先頭に棄却した旨を書いて残さなければ
  ならず、specification を持つ型では specification も提案の形で書かなければならない。作らないと
  決めた機能は、その `use_case` を `deprecated` にし、作らない理由を散文で補って記録しなければならない。
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:47:43+09:00"
---
# 規範は 1 ファイル 1 item のグラフが持ち、item の一覧は生成した index.md だけが持つ

## 仕様

規範を手書きの文書と item の両方に書くと二重管理になり、改訂で片方だけが古くなる。規範の所在を
グラフ側に一本化し、型ごとの item の一覧はグラフから生成した index.md が持つ。各ディレクトリの
手書きの README.md は、item から導けない全体像の散文だけを持つ。この分担は文書の分量ではなく
**どちらを正とするか**の宣言であり、README.md へ仕様や item の一覧を書き足すことは規範の複製にあたる。

**配置と採番を規約で固定する**のが要点になる。型を取り違えた item は形が正しい限り機械検証を
検出されずに通るため（[ドキュメントグラフのトレーサビリティは機械的に検証する](document-graph-mechanically-verified.md) の検証は参照の解決・一意性・非循環しか見ない）、正しい型へ置く
ことはレビューで守られる判断になる。採番を手で行わないのは、並列で作業するレーンが同じ番号を
採ることを構造的に避けるため。

二言語で書く規範は、英語と日本語のどちらも正として扱うことを含む。片方を訳注に降格させると、
実際に読まれる側の言語で規範の強度が落ちる。強度の対応（SHALL と「〜しなければならない」など）
まで含めた執筆規約は [specification は SHALL 系で書き、日本語の規範文は同じ強度の規範助動詞で終える](specification-shall-family-and-matching-auxiliaries.md) が持ち、これも機械検証されないためレビューで
守る。

型の判別基準の具体・採番コマンドの実装・強度の対応表は本 item の規範に含めない。判別は
[規範の型は、それが誰を縛るかで決める](norm-type-by-who-it-binds.md) が、執筆の規約は [specification は SHALL 系で書き、日本語の規範文は同じ強度の規範助動詞で終える](specification-shall-family-and-matching-auxiliaries.md) が、採番の仕組みは [トレーサビリティ検証基盤（sara によるドキュメントグラフの機械検証）](../infrastructure/traceability-verification.md) が持つ。

### 棄却した提案と作らないと決めた機能

`use_case`・`requirement`・`design` で棄却した提案は、提案の形の題で `status` を `deprecated` にして
残す。本文の先頭に棄却した旨を書き、`specification` を持つ型では `specification` も提案の形で書く。
作らないと決めた機能はその `use_case` を `deprecated` にし、作らない理由を散文で補う。`name` が提案を
表し、`status` が棄却を表すので、棄却 ADR と同じ読み方になる。

肯定の規範が中心で否定が付随するだけの item は対象にしない。題に否定が入っているなら、決定の形に
改めるだけにする。この範囲にした理由は
[棄却した提案の要求・要件・設計は提案の形の題で deprecated にして残す](../adr/rejected-proposals-deprecated-including-use-cases.md) が持つ。

## 出典

この item は [layat の同じ slug の item](https://github.com/yasunori0418/layat/blob/97ec53ae73d8f609e7a7c53feeb1baf6909fd76d/docs/quality/normative-items-placement-and-authoring.md) を写し、製品の形態に依らない文面に
直したもの。layat での運用の経緯は、原本の出典が持つ。

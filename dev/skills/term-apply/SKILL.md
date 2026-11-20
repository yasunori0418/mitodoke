---
name: term-apply
description: 台帳に溜めた用語を `ubiquitous_term` の item にし、索引を生成してコミットする。`/term-apply` の明示起動のみ。PR を作る前に実行する。新しい避ける綴りで既存の文書に違反が出たら、承認を取って同じブランチの別コミットで正名に直す。
license: MIT
disable-model-invocation: true
argument-hint: "[台帳のパス（省略時は tmp-agents/terms.md）]"
---

# term-apply: 台帳の語を用語 item にする

`term-record` が台帳に書いた語を、作業中のブランチで用語 item にする。item と、その語を使う文書が同じ PR で
レビューされるように、PR を作る前に実行する。

- 台帳の書式: [../term-record/references/ledger-format.md](../term-record/references/ledger-format.md)
- 用語 item の書式: [references/item-format.md](references/item-format.md)
- コマンドの呼び出し方: [references/commands.md](references/commands.md)

## 前提

- `docs/model.yaml` に `ubiquitous_term` の型があること。無ければ、このリポジトリは対象外と伝えて終える。
- 既定ブランチの上では実行しない。作業のブランチを切ってから実行するよう伝えて終える。
- 起票する語と直す箇所は、利用者が承認したものだけにする。承認には AskUserQuestion を使い、質問の要点と選択肢は
  本文にも書く。

## 手順

### 1. 台帳を読み、起こす語を決める

`$ARGUMENTS` のパス（省略時は `tmp-agents/terms.md`）を読み、状態が `未起票` の行を集める。1 行も無ければ、
その旨を伝えて終える。

集めた行を次の点で確かめる。当てはまる行は起こさずに、利用者へ訊く。

- `section` が空欄か、`docs/model.yaml` の `ubiquitous_term` の `section` の enum に無い
- `name` や `name_ja` が、別の slug の既存の item と同じ
- `avoid` の綴りが、ほかの語の正名（`name`・`name_ja`）と同じ

確かめた行を、新しく起こす語と、既存の item を変える語（slug が既存のファイルと同じ行）に分けて一覧にし、
このブランチで item にする語の承認を取る。

完了の条件: 承認された語の一覧が確定している。

### 2. item を起こす

承認された語を 1 語ずつ item にする。コマンドは [references/commands.md](references/commands.md)、frontmatter と
本文は [references/item-format.md](references/item-format.md) に従う。

- 新しい語は `sara-new` で起票し、雛形の本文を 4 節の書式に書き直す。frontmatter と ID を手で書かない。
- 既存の item を変える語は、そのファイルを編集する。本文を変えたら `generated` の `by` と `at` を更新する。
- 定義は、台帳の「定義の手がかり」と、そこが挙げる文書から書く。根拠にした文書と食い違う定義を書かない。

完了の条件: 承認された語すべてに、書式どおりの item がある。

### 3. 索引を生成し、検査する

索引 `docs/ubiquitous-language/index.md` を生成し、[references/commands.md](references/commands.md) の検査を
すべて実行する。索引は手で書かない。

`term-avoid` の違反は手順 4 で扱う。それ以外の検査が落ちたら、item を直して通す。

完了の条件: `term-avoid` のほかの検査がすべて exit 0。

### 4. 避ける綴りが残る箇所を直す

新しい `avoid` の綴りが既存の文書に残っていないかを、2 つの方法で調べる。

- `term-avoid` の検査の出力（散文の違反）
- 綴りの全文検索（[references/commands.md](references/commands.md)）。`term-avoid` は frontmatter を見ないので、
  `specification_ja` などに残る綴りはこちらでしか見つからない

見つけた箇所を「ファイル・行・いまの文面・直した後の文面」の一覧にして、承認を取ってから直す。

- 直すのは綴りの置き換えだけにする。文の意味は変えない。
- `avoid` を削らない。検査も変えない。
- 次の箇所は直さずに、一覧で別に示して利用者の判断を待つ: 規範の `specification` と `specification_ja`、
  `docs/adr/` の本文と name、置き換えると文の意味が変わる箇所。
- 本文を直した item は `generated` の `by` と `at` を更新する。その下流の item が再確認待ちに挙がるのは直さず、
  `verified` も足さない。

完了の条件: `term-avoid` が exit 0 で、全文検索に残るのは利用者の判断を待つ箇所だけ。`generated` の更新漏れが無い
（確かめ方は [references/commands.md](references/commands.md)）。

### 5. コミットする

commit-flow スキルがあれば、その手順でコミットする。コミットは 2 種類に分ける。

1. 用語 item と索引: `docs(ubiquitous-language): <語> の用語 item を起こす`（既存の item の変更なら「<語> の正名を直す」など、
   変えた内容を書く）
2. 手順 4 の直し: `docs: <避ける綴り> を <正名> に直す`

push と PR の作成はしない。

完了の条件: 作業ツリーに、このスキルが作った未コミットの変更が無い。

### 6. 台帳を更新し、報告する

item にした行の状態を `起票済み（<ブランチ名>）` に書き換える。報告には次を含める。

- 起こした語と、変えた既存の語
- 直した箇所の件数と、直さずに残した箇所（理由つき）
- 下流の item が再確認待ちに挙がるなら、PR の説明に「語の置き換えで、意味は変えていない」と書くこと

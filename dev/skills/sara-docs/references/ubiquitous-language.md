# 用語（ubiquitous_term）の引き方と起こし方

用語の正名は `ubiquitous_term` 型の item（`docs/ubiquitous-language/`、1 語 1 ファイル）が固定する。
`docs/ubiquitous-language/index.md` は `dev/scripts/okf-index.sh` が生成する語の一覧で、手で編集しない。

## 一覧から item を辿る

1. `docs/ubiquitous-language/index.md` を開き、主題の節から語を探す。各行は
   `` * [<英語の正名>（<日本語の正名>）](./<ファイル名>) - <description> `` の形になっている。
   `name_ja` の無い語は括弧ごと省く
2. リンク先の item を読む。正名は frontmatter、定義と避ける表現は本文にある
3. 一覧で見つからないときは、綴りが揺れている可能性があるので item 全体を検索する

```bash
rg -l -i '<探す語>' docs/ubiquitous-language/
```

## 正名と避ける綴りを機械的に取る

`sara check --format json` の `items[]` から取る。英語の正名は組み込みの `name` で、`fields` の外に
ある。日本語の正名 `name_ja` と避ける綴り `avoid` は `fields` の中にあり、どちらも任意なので
無い item もある。

```bash
sara check --format json | jq -r '
  .items[] | select(.type == "ubiquitous_term")
  | [.id, .name, (.fields.name_ja // ""), ((.fields.avoid // []) | join(", "))] | @tsv'
```

## frontmatter と本文の様式

用語 item の書式の正本はこの節。`sara-new` が frontmatter を書くので、手で足すのは既存の item を変えるときだけ。

- `name`: 英語の正名。英語の正名が一次になる。型やフィールドの名前なら `snake_case` の識別子にする
- `description`: 日本語の 1 文の要約。定義の最初の文と同じ内容にする
- `name_ja`: 日本語の正名。英語のまま使う語では、キーごと省く
- `avoid`: 執筆で使わない綴りのリスト。綴りだけを書き、避ける理由と言い換えは本文に書く。
  他の語の正名として正しく使う綴りは入れない。入れると検出が偽陽性になる。避ける綴りが無ければ、キーごと省く
- `section`: 索引の節。`docs/model.yaml` の `ubiquitous_term` の enum の値
- `status`: `stable`
- relation は持たない。ADR や QA、REQ / DSG へ辺を張らない

本文は `# <name>` の見出しの下に、次の 4 節をこの順で置く。見出しは `name` そのものにする。`sara init` が
生成する `## Overview` と `## Name (ja)` の雛形は消す。

| 見出し | 書くこと |
|---|---|
| `## Definition` | 英語の定義 |
| `## Avoid` | `- <綴り>: <避ける理由と言い換え>` の箇条書き（英語）。`avoid` を持たない語では節ごと省く |
| `## 定義` | 日本語の定義 |
| `## 避ける表現` | `- <綴り>: <避ける理由と言い換え>` の箇条書き（日本語）。`avoid` を持たない語では節ごと省く |

- 定義は、その語が何であるかを述べる。1 段落に収め、英語と日本語を同じ内容にする
- モデルの型を表す語の定義は、フィールドと relation を写さずに `docs/model.yaml` を指す
- 特定の製品の機能を例に使わない
- ほかの item に触れるときは、ID を書かずにリンクで触れる

実例は `docs/ubiquitous-language/stale.md`（`avoid` を持つ語）と `docs/ubiquitous-language/norm.md`（持たない語）。

## 執筆での使い方

- 語は item の正名で書く。`avoid` にある綴りは使わない
- `avoid` の綴りは契約テスト `dev/tests/term-avoid.sh`（textlint + prh）が検出する。対象は docs・README・AGENTS.md で、ADR・用語 item は除く
- 必要な語の item が無ければ、その場で綴りを決めずに item を起こすか、既存の語を選ぶ

## 語が無いときに item を起こす

議論の中で決まった語は、`term-record` スキルが台帳へ書き、`/term-apply` が PR の前にまとめて item にする。
下のコマンドは、その中で使う起票の形。


```bash
sara-new ubiquitous_term <slug> docs/ubiquitous-language -- \
  --name '<英語の正名>' --description '<1 文の要約>' --section '<節の値>' --status stable \
  [--name-ja '<日本語の正名>'] [--avoid '<綴り>' ...]
```

`--section` は語を載せる index.md の節の値で、省かずに渡す。取りうる値は `docs/model.yaml` の
`ubiquitous_term` の enum にある。`--avoid` は綴り 1 つごとにフラグを繰り返す。起こしたら本文の
4 節を書き、`dev/scripts/okf-index.sh` で index.md を再生成して、`sara check` が通ることを確かめる。

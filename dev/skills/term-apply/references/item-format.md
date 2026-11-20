# 用語 item の書式

用語 item は `docs/ubiquitous-language/<slug>.md` に 1 語 1 ファイルで置く。型は `ubiquitous_term` で、relation を
持たない。型とフィールドの正本は `docs/model.yaml`。

## frontmatter

`sara-new` が書く。手で足すのは、既存の item を変えるときだけ。

| キー | 書くこと |
| --- | --- |
| `name` | 英語の正名。台帳の `name` |
| `description` | 日本語の 1 文の要約。定義の最初の文と同じ内容にする |
| `name_ja` | 日本語の正名。台帳で空欄なら、キーごと持たない |
| `avoid` | 避ける綴りのリスト。綴りだけを入れる。台帳で空欄なら、キーごと持たない |
| `section` | 索引の節。`docs/model.yaml` の enum の値 |
| `status` | `stable` |
| `generated` | `sara-new` が付ける。本文を変えたら `by` と `at` を更新する |

## 本文

`sara-new` が作る雛形（`## Overview` など）は消し、次の形に書き直す。

```markdown
# <name>

## Definition

<英語の定義>

## Avoid

- <綴り>: <避ける理由と言い換え（英語）>

## 定義

<日本語の定義>

## 避ける表現

- <綴り>: <避ける理由と言い換え（日本語）>
```

- H1 は `name` そのもの。
- 節の順は `## Definition`・`## Avoid`・`## 定義`・`## 避ける表現`。`avoid` を持たない語では `## Avoid` と
  `## 避ける表現` を省く。
- 定義は、その語が何であるかを述べる。1 段落に収める。
- 英語と日本語の定義は同じ内容にする。
- モデルの型を表す語の定義は、フィールドと relation を写さずに `docs/model.yaml` を指す。
- 特定の製品の機能を例に使わない。
- ほかの item に触れるときは、ID を書かずにリンクで触れる
  （[フル ID は frontmatter だけに書き、散文では item にリンクで触れる](../../../../docs/quality/full-ids-in-frontmatter-links-in-prose.md)）。

実例は `docs/ubiquitous-language/stale.md`（`avoid` を持つ語）と `docs/ubiquitous-language/norm.md`（持たない語）。

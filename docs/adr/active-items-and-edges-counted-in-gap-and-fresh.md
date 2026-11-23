---
id: "ADR-394484db-988a-4fe0-b390-805e79bccec1"
type: adr
name: "有効な item だけを gap と fresh で数え、辺は両端が有効なものだけを数える"
description: "status が deprecated でない item を有効な item と 1 か所で定義し、gap と fresh はすべての節で有効な item と両端が有効な辺だけを数え、check の構造の契約は deprecated の item にも働かせる。"
section: inspection
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
references:
  - "ADR-3fe7901b-5cc0-4677-8761-fcdd4118450a"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:47:47+09:00"
---
# 有効な item だけを gap と fresh で数え、辺は両端が有効なものだけを数える

- ステータス: stable
- 日付: 2026-11-23
- 関連: [deprecated の item は index.md の末尾の節にまとめる](deprecated-items-listed-at-index-end.md), GitHub Issue #74, GitHub Issue #81
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

`status` が `deprecated` の item をどの検査と報告で数えるかが、要件ごとにばらばらに書かれていた。issue #80
で加えた `gap` の節の要件と、再確認待ちの要件は、`deprecated` の item を除くと定めている。写した
`sara-gap` の既存の 5 節だけが `deprecated` の item も数えていて、issue #81 が欠陥として扱っている。
辺の片方の端が `deprecated` の item であるとき、その辺を数えるかは、issue #81 で決まっていなかった。

## 決定

「有効な item」を「`status` が `deprecated` でない item」と 1 か所で定義し、次のように使い分ける。

- `check` の構造の契約は、`deprecated` の item にも働かせる
- `gap` と `fresh` は、すべての節で有効な item だけを数える。辺は、両端が有効な item のものだけを数える
- `index` は、[deprecated の item は index.md の末尾の節にまとめる](deprecated-items-listed-at-index-end.md)
  のとおりにする

## 根拠

定義を 1 か所に置けば、検査と報告のどれも同じ item の集合を数え、要件ごとの書き方の違いで結果が
食い違わない。

`deprecated` の item は、もう読まなくてよい成果物なので、それが残す辺で欠けを埋めたことにすると欠けを
見逃す。`deprecated` の risk からの `threatens` で requirement を覆ったことにすると、有効な risk の無い
requirement を報告しなくなる。

構造の契約は、文書が読める形であるかを見るので、`deprecated` の item にも働かせる。`deprecated` の ADR も、
`justifies` が無ければ失敗にする。

辺の数え方をここで決めておけば、issue #81 はこの規則を script に写すだけになる。

## 棄却した代替案

### 辺の数え方を issue #81 に任せ、この決定は「有効な item」の定義だけを持つ

決定は小さくなるが、辺の数え方が script の修正の中で決まり、CLI の実装と script の結果が食い違いうる。

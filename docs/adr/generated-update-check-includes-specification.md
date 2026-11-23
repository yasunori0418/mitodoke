---
id: "ADR-50a84bb0-0aba-42bc-b96b-9c7be48d69fe"
type: adr
name: "generated の更新漏れの検査は、frontmatter の specification も本文に数える"
description: "base との差分で、frontmatter の外の行と `specification`・`specification_<言語>` が変わったのに `generated.at` が変わっていない item を更新漏れとして挙げ、基準のリビジョンが無ければ検査せずにそのことを記録する。"
section: verification
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定。generated の更新漏れは PR の差分で確かめる ADR を書き直した"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
supersedes:
  - "ADR-5ef8ab39-cefe-4c6f-b743-730316d96568"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:51:39+09:00"
---
# generated の更新漏れの検査は、frontmatter の specification も本文に数える

- ステータス: stable
- 日付: 2026-11-23
- 関連: [generated の更新漏れは PR の差分で確かめる](generated-update-checked-in-pr-diff.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定。generated の更新漏れは PR の差分で確かめる ADR を書き直した

## 背景

本文を変えたら `generated` を更新する規約がある。`generated.at` が古いまま残ると、上流の relation を辿る
鮮度の比較が、本文の変更を見落とす。そのため、base との差分で本文が変わったのに `generated.at` が
変わっていない item を、更新漏れとして挙げている。

本文は frontmatter の外の行としていた。PR #88 では、`specification` だけを直した要件でも `generated` を
更新するとメンテナが裁定した。規範が変わった item は、下流が再確認待ちに挙がるほうが安全だからである。
写した `sara-fresh` は frontmatter の外だけを比べるので、この変更を更新漏れに挙げない。

基準のリビジョンを渡さない実行で、この検査をどう扱うかも決まっていなかった。

## 決定

base との差分で本文が変わったのに `generated.at` が変わっていない item を、更新漏れとして挙げる。時刻は
比べない。

- 本文は、frontmatter の外の行に、frontmatter の `specification` と `specification_<言語>` を加えたもの
  とする。`name`・`description`・`status`・relation・OKF のキーの変更は、本文の変更に数えない
- 比べる 2 点は、`git merge-base <base> HEAD` のコミットと作業ツリーとする
- frontmatter の外の行では、`# ` で始まる H1 の行、`- ステータス:` で始まる行、空白だけの差を除いて差が
  あれば、本文が変わったとみなす
- 新しく足した item と削除した item は対象にしない。改名した item は旧パスの内容と比べる
- 挙げた結果は報告に留める
- 基準のリビジョンを渡さない実行では、この検査をしない。`check` と `fresh` は、検査しなかったことを
  結果に記録する。基準のリビジョンを暗黙に決めることはしない

## 根拠

`specification` は item の規範そのものなので、それを変えたら下流が再確認待ちに挙がるべきである。
`specification` を本文に数えれば、規範を変えて `generated` を更新し忘れた item を挙げられる。
`name`・`description`・`status`・relation・OKF のキーは、規範の中身ではなく、item の見出しや状態や
つながりなので、数えない。

更新漏れは本文を変えるその変更の中で起きる。PR の差分を見れば、変更した item ごとに本文と
`generated.at` が一緒に変わったかを判定でき、時刻の精度に左右されない。H1 と `- ステータス:` の行は
frontmatter の `name` と `status` を写した行で、写しただけの変更では `generated` を更新しない。空白だけの
差は意味を変えない。新しく足した item は起票時に `generated` が付き、削除した item は残らないので、比べる
相手が無い。改名は `generated` を更新しない変更なので、旧パスの内容と比べて本文の差だけを見る。

基準のリビジョンが無ければ、比べる 2 点が決まらない。暗黙に決めると、実行する場所や時点で比べる相手が
変わる。検査しなかったことを結果に残せば、更新漏れが無かったのか、検査しなかったのかを読み分けられる。

## 棄却した代替案

### `generated`・`verified`・`status` のほかの frontmatter をすべて本文に数える

規則は単純になるが、relation を 1 本加えただけでも `generated` の更新が要るようになる。

### 全履歴で、本文を変えたコミットの時刻と `generated.at` を比べる

規約どおりに書いた item でも、`generated.at` はコミットの author date より数分古くなる。本文を書いた時刻に
`generated` を付け、その後にコミットするためである。機械的な一括書き換えのコミットも履歴に並び、
更新漏れを見分けられない。

### 許容幅を付けて時刻を比べる

書いてからコミットするまでの時間には上限が無く、幅をいくつにしても規約どおりの item が外れるか、
更新漏れを見逃す。一括書き換えのコミットは幅では除けない。

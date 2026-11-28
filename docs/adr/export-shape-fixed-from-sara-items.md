---
id: "ADR-aa5502df-77b9-41cc-94e9-1480ab6500ce"
type: adr
name: "export は sara 0.12 の items[] の形を写して固定し、OKF のキーを加える"
description: "export の形は今の sara 0.12 の items[] を写して mitodoke の形として固定し、OKF のキーを加えて outturn の item の info の下に置き、sara の形が変わっても自動では変えない。"
section: json-output
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q21・Q42）で確定"
justifies:
  - "REQ-4ac9181f-5394-4617-b05e-be2387228008"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:35:12+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:26:51+09:00"
---
# export は sara 0.12 の items[] の形を写して固定し、OKF のキーを加える

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q21・Q42）で確定

## 背景

mitodoke の `export` は、item の一覧を JSON で出す。この JSON を、どの形で出すかを決める必要が
あった。

sara の `sara check --format json` の形は、sara の CLI の中の非公開の struct で決まっていて、
mitodoke が組み込む `sara-core` からは使えない。この形は sara 0.12.0 の破壊的変更で今の形になり、
それ以前は `item_type`・`attributes` などを使う別の形だった。今の `items[]` は、`id`・`type`・
`name`・`description`・`file`・`relations`（そのファイルが宣言した relation だけ）・`fields`（宣言した
フィールドだけ）を持ち、本文と宣言の無いキーは含まない。OKF の `generated`・`verified`・`sources`
は入れ子の値を持つので、sara の model.yaml では宣言できず、sara の JSON にも出ない。

## 決定

`export` の item は文書 1 件ずつにする。今の sara（0.12）の `sara check --format json` の `items[]`
の形を写して mitodoke の形として固定し、OKF のキー（`generated`・`verified`・`sources`・
`stale_after`）を加えて、outturn の item の `info` の下に置く。sara の形が変わっても自動では
変えず、変えるかは mitodoke の側で決める。sara の形そのものが要る利用者は、同梱の sara CLI の
`sara check --format json` を使う。

## 根拠

利用者は、基本的な形を sara に合わせることを求めた。今の形を写して固定すれば、形を sara に
合わせつつ、出力の形を変えるかどうかの判断を mitodoke の側に残せる。sara の破壊的変更に出力の
形が引きずられないので、この出力から適用先の製品が組み立てた検査も、sara を上げるたびに直さずに
済む。

## 棄却した代替案

### sara の形に追従する

sara を上げて形が変わったら、mitodoke の出力も同じように変える案。OKF のキーは加える。sara の
破壊的変更が、そのまま mitodoke の出力の破壊的変更になる。sara の CLI の非公開の struct を写す
ので、sara のバージョンを上げるたびに写し直しが要る。

### mitodoke 自身の形を決めて出す

item ごとに、ID・型・名前・ファイルのパス・宣言されたフィールド・relation と OKF のキーを含む、
mitodoke 独自の形を決める案。いったんはこの案を採ったが、利用者が基本的な形を sara に合わせる
ことを求めたので、今の sara の形を写して固定する形に改めた。

---
id: "ADR-a8d24a10-21fd-40bb-a684-8bdf625597ed"
type: adr
name: "specification は英語で必須にし、ほかの言語は設定で選ぶ"
description: "specification は英語で必須にし、ほかの言語は設定で選んで specification_<言語> と name_<言語> のフィールドを生成する。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q11）で確定"
justifies:
  - "REQ-ade865fa-90ea-43c3-b504-4566bb9582ae"
references:
  - "ADR-5cddbc1a-b9bc-46ae-8272-c567153643f9"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:31:34+09:00"
---
# specification は英語で必須にし、ほかの言語は設定で選ぶ

- ステータス: stable
- 日付: 2026-11-17
- 関連: [specification の必須の強度を SHALL 系の綴りに固定する](specification-shall-family-fixed.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q11）で確定

## 背景

`requirement`・`quality`・`test_plan` は、英語の `specification` と日本語の `specification_ja` の
二言語で規範を書く。sara は、フィールド名が `specification` のものにだけ RFC2119 のキーワード
（SHALL など）を求め、`specification_ja` は検査しない。文書管理の規範は、`specification` を SHALL 系
だけで書き、`specification_ja` は同じ強さの助動詞で終えると定め、英語と日本語のどちらも正としている。
model.yaml の placeholder には、製品の名前を含む日本語の文がある。

mitodoke を製品にするにあたり、この二言語の書き方をどう一般化するかを決めなければならない。

## 決定

`specification` は英語で必須にする。ほかの言語は設定で選び、`specification_<言語>` と
`name_<言語>` のフィールドを生成する。

## 根拠

`specification` を英語にしておけば、sara の RFC2119 の検査がそのまま働く。

二言語で書くかどうかはプロジェクトの選択なので、言語の一覧を設定に持たせ、フィールドと
placeholder を生成する。placeholder を生成するので、特定の製品の名前を placeholder に書かずに済む。

## 棄却した代替案

### 英語だけにする

`specification_ja` をやめ、英語だけで書く案。二言語で書くかどうかをプロジェクトが選べなくなる。

### 主な言語を設定で選び、specification をその言語で書く

英語以外を選ぶと、sara の RFC2119 の検査が働かなくなる。

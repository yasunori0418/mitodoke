---
id: "ADR-d252b2c6-d54a-40a7-9d0b-3658b333d1dc"
type: adr
name: "規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する"
description: "mitodoke のリポジトリ自身を mitodoke で管理して規範と文書管理の決定を持ち、適用先の製品は規範を写さず mitodoke の文書として参照する"
section: product-scope
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q6）で確定"
justifies:
  - "QA-ae2f173b-e4b1-412b-8b1f-bcdc38b46170"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:34:44+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:34:16+09:00"
---
# 規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q6）で確定

## 背景

製品には文書管理の規範（quality 14 本）を含める。この規範と、文書管理の決定の記録を
どこに置くかを決める必要があった。

sara の走査対象（`sara.toml` の `repositories.paths`）は複数のディレクトリを持てる。ただし、
別のリポジトリの item を ID で指すには、そのディレクトリを走査対象に加える必要がある。
加えなければ、参照先の無い ID として扱われる。

## 決定

mitodoke のリポジトリ自身を mitodoke で管理する。solution は mitodoke、規範 14 本は mitodoke の
quality item、文書管理の決定は mitodoke の adr にする。適用先の製品は規範を自分のグラフへ
写さず、mitodoke の文書として参照する。

適用先の製品の走査対象に mitodoke の規範のディレクトリを加え、ID で参照する形は、後から
加えられる。この形は試していない。

## 根拠

規範を適用先の製品へ複製すると、mitodoke のバージョンを上げたときに、適用先の写しが古い
まま残る。mitodoke 自身を mitodoke で管理すれば、最初から実際のグラフで CLI を確かめられる。

適用先の製品のグラフが規範の item を持たなくても、規範のうち機械で確かめられるものは CLI の
検査が確かめ、残りは mitodoke の文書として読まれる。

## 棄却した代替案

### 規範を雛形の item として配り、初期化のコマンドで適用先の製品のグラフへ複製する

mitodoke 自身は自分を mitodoke で管理しない案。mitodoke のバージョンを上げたときに、適用先の
写しが古いまま残る。実際のグラフで CLI を確かめる機会も得られない。

### 規範を item にせず、README などの散文の文書として持つ

規範が mitodoke のグラフの item にならないので、規範を含めた実際のグラフで CLI を確かめる
ことができない。

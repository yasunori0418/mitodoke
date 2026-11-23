---
id: "ADR-018c5063-a4e5-4b59-899f-f1a62cda67e3"
type: adr
name: "既存の文書への generated の埋め戻しは CLI に持たず、README に例を載せる"
description: "既存の文書を持つ適用先の製品が item に generated を付ける機能を mitodoke の CLI に持たず、README の導入の手順に埋め戻しの例を載せる。"
section: frontmatter-fields
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 6 節（適用先の製品への導入）"
origin: "issue #72 の grilling（2026-11-22）で確定"
justifies:
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:13:53+09:00"
---
# 既存の文書への generated の埋め戻しは CLI に持たず、README に例を載せる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](../requirements/constraints-on-top-of-okf.md), GitHub Issue #72, GitHub Issue #6
- 起点: issue #72 の grilling（2026-11-22）で確定

## 背景

mitodoke はすべての item に `generated` を持たせる
（[OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](../requirements/constraints-on-top-of-okf.md)）。
既存の文書を持つ製品に mitodoke を導入すると、既存の item には `generated` が無い。その item に `generated` を
付ける手段が、CLI に持つか、README の手順にするか、持たないかを含めて決まっていなかった。

layat では一度きりの script で `generated` を埋め戻した。`generated.at` には、frontmatter の外の本文を
最後に変えたコミットの author date を入れ、`generated.by` には、そのコミットの `Co-Authored-By` の表示名を
変換した値か、無ければ引数で渡した既定の値を入れた。mitodoke はこの script を写していない。

## 決定

- 既存の文書へ `generated` を埋め戻す機能を、mitodoke の CLI に持たない
- README の導入の手順に、埋め戻しの例を載せる

## 根拠

git の履歴から `generated.by` を推定する規則は、製品ごとに違う。CLI に持つと、一度きりの移行のために
サブコマンドを保守することになる。

## 棄却した代替案

### 埋め戻しのサブコマンドを要件にする

`generated.by` を推定する規則が製品ごとに違うので、一度きりの移行のためにサブコマンドを保守することになる。

### README にも埋め戻しの例を載せない

記録にはこの案に固有の不採用の理由は無い。利用者は CLI に持たず README に例を載せる形を選んだ。

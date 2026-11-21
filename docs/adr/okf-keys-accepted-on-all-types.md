---
id: "ADR-e0faef6d-5dd6-46a9-a8d8-42d63003ce99"
type: adr
name: "OKF のキーは型を問わず受け付け、OKF v0.2 の定義に従うかを検査する"
description: "OKF のキーをどの型の item でも受け付け、OKF v0.2 の定義に従っているかを構造の契約として検査する。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（共有の理解の確認）で確定"
justifies:
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
references:
  - "ADR-bab72f31-7cb1-47a3-bb2d-7876757d86fb"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:02+09:00"
---
# OKF のキーは型を問わず受け付け、OKF v0.2 の定義に従うかを検査する

- ステータス: stable
- 日付: 2026-11-17
- 関連: [OKF v0.2 と互換の frontmatter キーを item に足す](okf-compatible-frontmatter.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（共有の理解の確認）で確定

## 背景

item は、OKF v0.2 と互換の frontmatter のキー（`generated`・`verified`・`sources`・`stale_after`）を
持つ。宣言の無い frontmatter のキーは構造の契約の違反になるが、OKF のキーはこの違反から
除いている。この除外は型を問わない。写した `dev/tests/okf-frontmatter.sh` も、入れ子のキーの
形を型で絞らずに確かめている。

OKF のキーをどの型で受け付けるかは、grilling の質問では訊かず、推奨した側の見立て（型を
問わず受け付ける）のまま、共有の理解の確認に残っていた。

## 決定

OKF のキー（`generated`・`verified`・`sources`・`stale_after`）は、型を問わず受け付ける。
受け付けたキーが OKF v0.2 の定義に従っているか（形と値）を、構造の契約として検査する。

OKF より厳しい mitodoke の制約は、この検査の上に重ねる。

## 根拠

OKF のキーを宣言の無いキーの違反から除くことは型を問わないので、受け付けも型で分けない
ほうが揃う。

共有の理解の確認で、利用者は、OKF のキーについて OKF v0.2 の定義に従っているかを検査する
ことを求めた。受け付けるだけでなく、形と値を検査に含めた。

## 棄却した代替案

### OKF のキーを受け付ける型を限る

`sources` などを特定の型にだけ許す案。OKF のキーを宣言の無いキーの違反から除くことは型を
問わないので、型によって受け付けを分けると、この除外と食い違う。

### 型を問わず受け付けるが、OKF v0.2 の定義に従うかは検査しない

共有の理解の確認に残っていた見立てのままの形。利用者が OKF v0.2 の定義に従っているかの
検査を求めたので採らなかった。

---
id: "ADR-af43255d-2fd6-4351-917f-ed9bf9d9ae0e"
type: adr
name: "宣言の無い frontmatter のキーを構造の契約の違反にする"
description: "model で宣言されていない frontmatter のキーを構造の契約の違反として mitodoke check で失敗にし、OKF のキーは違反にしない。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q22）で確定"
justifies:
  - "REQ-9c54aa84-e2db-42d7-87af-f1fec5c64a63"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:54:53+09:00"
---
# 宣言の無い frontmatter のキーを構造の契約の違反にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q22）で確定

## 背景

sara は、model.yaml で宣言していないキーが frontmatter にあっても、エラーにせずに受け付ける。
ただし、そのキーを検査もせず、JSON にも出さない。mitodoke では、適用先の製品が独自の
フィールドを設定で宣言できる。宣言の無いキーを mitodoke がどう扱うかを決める必要があった。

## 決定

宣言の無い frontmatter のキーは、構造の契約の違反として `mitodoke check` で失敗にする。
ほかの検査と同じく、強さは設定で変えられる。

OKF のキー（`generated`・`verified`・`sources`・`stale_after`）は mitodoke が扱うので、
違反にしない。

## 根拠

フィールドを設定で宣言する手段があるので、宣言せずに書く理由は残らない。

宣言の無いキーは、検査にも JSON 出力にも入らない。書いた人が期待した働きをせず、
しかもそれに気づく手段が無い。違反として失敗にすれば、書いた時点で気づける。

## 棄却した代替案

### つながりの欠けと同じく、CI で報告するだけにする

記録には、この案に固有の不採用の理由は無い。利用者は、構造の契約の違反として失敗にする
推奨の案を選んだ。

### sara と同じく、エラーにせずに受け付けて無視する

宣言の無いキーが検査にも JSON 出力にも入らないまま、書いた人がそれに気づく手段が無い。

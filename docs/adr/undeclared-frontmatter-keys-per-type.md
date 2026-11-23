---
id: "ADR-2fd15581-e1fb-4eb0-9549-024bb6b4015a"
type: adr
name: "宣言の無い frontmatter のキーを違反にし、宣言はその item の型のものに限る"
description: "sara の組み込みのキー、OKF の 4 つのキー、その item の型で宣言されたフィールドと relation のどれでもない frontmatter のキーを構造の契約の違反として mitodoke check で失敗にし、ほかの型だけで宣言されたフィールドも違反にする。"
section: inspection
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 7 節（undeclared-frontmatter-keys が受け付けるフィールドの範囲）"
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "issue #72 の grilling（2026-11-22）で確定。宣言の無い frontmatter のキーを構造の契約の違反にする ADR を書き直した"
justifies:
  - "REQ-9c54aa84-e2db-42d7-87af-f1fec5c64a63"
supersedes:
  - "ADR-af43255d-2fd6-4351-917f-ed9bf9d9ae0e"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:54:23+09:00"
---
# 宣言の無い frontmatter のキーを違反にし、宣言はその item の型のものに限る

- ステータス: stable
- 日付: 2026-11-22
- 関連: [宣言の無い frontmatter のキーを構造の契約の違反にする](undeclared-frontmatter-keys-rejected.md), GitHub Issue #72, GitHub Issue #6, GitHub Issue #4
- 起点: issue #72 の grilling（2026-11-22）で確定。宣言の無い frontmatter のキーを構造の契約の違反にする ADR を書き直した

## 背景

sara は、model.yaml で宣言していないキーが frontmatter にあっても、エラーにせずに受け付ける。
ただし、そのキーを検査もせず、JSON にも出さない。mitodoke では、適用先の製品が独自の
フィールドを設定で宣言できる。宣言の無いキーを mitodoke がどう扱うかを決める必要がある。

宣言の無いキーを違反にすると決めた時点では、受け付ける「model で宣言されたフィールド」を、その item の型で
宣言されたものに限るかが決まっていなかった（#6 のコメントの 7 節）。

## 決定

item の frontmatter で受け付けるキーは、次のものに限る。

- sara の組み込みのキー
- OKF の 4 つのキー（`generated`・`verified`・`sources`・`stale_after`）
- その item の型で宣言されたフィールドと relation

それ以外のキーは、構造の契約の違反として `mitodoke check` で失敗にする。ほかの型だけで宣言された
フィールドも違反にする。ほかの検査と同じく、強さは設定で変えられる。

## 根拠

フィールドを設定で宣言する手段があるので、宣言せずに書く理由は残らない。

宣言の無いキーは、検査にも JSON 出力にも入らない。書いた人が期待した働きをせず、
しかもそれに気づく手段が無い。違反として失敗にすれば、書いた時点で気づける。

フィールドと relation は型ごとに宣言する。ほかの型だけで宣言されたフィールドは、その item の型では
宣言されていないキーである。

OKF のキーは mitodoke が扱うので、違反にしない。

## 棄却した代替案

### model のどれかの型で宣言されたフィールドなら受け付ける

記録には、この案に固有の不採用の理由は無い。宣言をその item の型のものに限る案を選んだ。

### つながりの欠けと同じく、CI で報告するだけにする

記録には、この案に固有の不採用の理由は無い。利用者は、構造の契約の違反として失敗にする
推奨の案を選んだ。

### sara と同じく、エラーにせずに受け付けて無視する

宣言の無いキーが検査にも JSON 出力にも入らないまま、書いた人がそれに気づく手段が無い。

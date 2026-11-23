---
id: "ADR-7f1ac4f7-75b3-4837-9825-025a23f1673b"
type: adr
name: "構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする"
description: "検査の既定の強さを、構造の契約は失敗、つながりの欠けと見直しの義務は CI での報告とし、どの検査も設定で強さを変えられるようにする。"
section: inspection
status: deprecated
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q3）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
references:
  - "ADR-bf25a81b-d588-4c7e-9365-fe514ee4d626"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:49:27+09:00"
---
# 構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にする

> **廃止（2026-11-22）**: 本 ADR の決定は次の後継へ移った。以下の本文は当時の記録として読む。
>
> - 全体 → [構造の契約は失敗、つながりの欠けと見直しの義務は報告を既定にし、それぞれの列挙を閉じる](default-strength-with-closed-lists.md)

- ステータス: deprecated
- 日付: 2026-11-17
- 関連: [sara check を strict モードで回す](sara-check-strict-mode.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q3）で確定

## 背景

mitodoke の検査には、item の構造が契約に合っているかを見るもの、relation の欠けを見るもの、
上流の変更などで人が見直すべき item を見るものがある。どれを失敗にし、どれを報告に留めるかの
既定を、製品として決める必要があった。

写した script の運用では、`sara check`（strict）と独自の検査が CI の job を失敗させ、
`sara-fresh` は報告だけを出す。`sara-gap` は CI で実グラフに当てておらず、手で実行したときだけ
該当ありを exit 1 で返す。

コンセプト文書は、機械は特定して報告し、人間が評価して判断すると書く（§4.2）。また、
test_condition は検討すべき観点で、必ず実行することを意味しないと書く（§5.1・§5.2）。

## 決定

検査の既定の強さを次のように分ける。

- 構造の契約は失敗にする。`sara check`、frontmatter の形、ID の置き場所、test_case とテスト資産の
  1:1、risk の level の導出、supersedes の先が deprecated であること、index.md の差分が当たる
- つながりの欠けは CI で報告する。covers されない test_condition、mitigates されない risk、
  threatens されない requirement、satisfies されない quality が当たる
- 見直しの義務は CI で報告する。上流の変更による再確認待ち、generated の更新漏れ、人の確認が
  無い high の risk が当たる

どの検査も、設定で強さを変えられる。CI のどの job を必須にするかは、mitodoke ではなく適用先の
製品が決める。

## 根拠

つながりの欠けを報告にすれば、CI を失敗させずに、毎回の CI で欠けを見えるようにできる。

つながりの欠けのうち、報告に留める根拠がコンセプトにあるのは test_condition の扱いだけである。
test_condition は必ず実行するものではないので、covers されない test_condition で CI を失敗させると
コンセプトと食い違う。mitigates されない risk、threatens されない requirement、satisfies されない
quality を報告にするのは、推奨した側の判断である。コンセプトはリスクから明示的なテスト条件が
導出されている状態を目指すと書いており（§3）、これらを失敗にする読み方もできる。その場合は、
設定で強さを上げられる。

## 棄却した代替案

### 写した script の今の扱いのまま

`sara-gap` は CI で実グラフに当てず、手で実行したときだけ exit 1 の失敗にし、`sara-fresh` は報告に
する案。つながりの欠けが、手で実行したときにしか見えない。`sara-gap` をそのまま CI につなぐと、
covers されない test_condition が 1 件でもあれば CI が失敗し、test_condition を必須の実行としない
コンセプトと食い違う。

### すべての検査で失敗を既定にし、設定で緩める

記録には、この案に固有の不採用の理由は無い。採った案の根拠（covers されない test_condition で
CI を失敗させると、test_condition を必須の実行としないコンセプトと食い違う）に照らして採らなかった。

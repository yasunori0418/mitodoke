---
id: "ADR-df3de1e7-fccf-48f2-9810-0553434bb7be"
type: adr
name: "level の導出表を設定で変えられるようにし、値の集合は固定する"
description: "likelihood と impact の組から level への対応を設定で変えられるようにし、設定に無ければ既定の 9 通りの表を使い、low・medium・high の値の集合は製品で固定する。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q33）で確定"
justifies:
  - "REQ-cfa09935-9066-433a-a3ef-05ca83ad9a22"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:38+09:00"
---
# level の導出表を設定で変えられるようにし、値の集合は固定する

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q33）で確定

## 背景

risk の `level` は、`likelihood` と `impact` の組から表で導く。表は、`likelihood` と `impact` が
それぞれ low・medium・high の 9 通りの組に `level` を対応させる。たとえば `likelihood` が high で
`impact` が low なら medium、`likelihood` が low で `impact` が high でも medium になる。

導いた `level` は、test_condition の優先度（`mitigates` で守る risk のうち最も高い `level`）と、
人の確認が無い `level` が high の risk の報告に使う。表の使い方を定めた規範
（[risk の level は likelihood と impact から導き、手で決めない](../quality/risk-level-derived-from-likelihood-and-impact.md)）は、
製品に含める文書管理の規範の 1 つである。

この表を製品で固定するか、設定で変えられるようにするかを決めなければならない。

## 決定

`likelihood` と `impact` の組から `level` への表を、設定で変えられるようにする。設定に書かなければ
既定の 9 通りの表を使う。

- 設定で変えられるのは、`likelihood` と `impact` の組から `level` への対応だけとする
- `likelihood`・`impact`・`level` の値の集合（low・medium・high）は製品で固定する

## 根拠

grilling では、表を製品で固定せず、適用先の製品が設定で変えられるようにすることを選んだ。
この案を選んだ理由は、決定記録に残っていない。
設定に書かなければ既定の表を使うので、設定を書かない製品の判定は既定の表のまま変わらない。

値の集合を固定するのは、人の確認が無い `level` が high の risk の報告が、`level` の値 `high` を
前提にするためである。

この決定では、次の代償を受け入れた。導出表を変えると、既存の risk の `level` が導出と食い違い、
`mitodoke check` が失敗する。表を変える PR で、`level` も書き直すことになる。

## 棄却した代替案

### 製品で固定する

表を製品で固定し、既定の 9 通りの表だけを使う案。grilling で推奨した案だった。推奨の理由は次の
とおりである。いまの適用先はどれも同じ表を使うので、表を変えたい具体的な場面はまだ無い
（コンセプト文書の設計原則「先回りした抽象化を避ける」）。あとから設定で変えられるようにしても、
設定を書いていない製品の判定は変わらない。逆に、いったん設定を許してから固定に戻すと、表を
変えていた製品の判定が変わってしまう。固定から始めて、必要になったときに設定へ広げるのが安全
である。grilling の回答は、この案ではなく、設定で変えられるようにする案だった。回答がこの案を
採らなかった理由は、決定記録に残っていない。

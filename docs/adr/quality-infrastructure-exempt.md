---
id: "ADR-89e932f4-e4fe-4387-b9e8-d697c4d1ec2f"
type: adr
name: "quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す"
description: "quality に任意の text の infrastructure_exempt を足して理由の 1 文を書かせ、gap はそれを持つ quality を未カバーから外して情報の節に一覧にし、規範を quality 1 本として起こす。"
section: inspection
status: stable
sources:
  - id: "issue-31"
    resource: "https://github.com/yasunori0418/mitodoke/issues/31"
    title: "epic: 規範とテスト計画を支える仕組みを決める — infrastructure に satisfies されていない quality と、test_plan の支え"
origin: "#31 の grilling（2026-11-26）で確定"
justifies:
  - "QA-cddaeec3-b9f7-458a-815a-6a14213557ed"
  - "INF-dee49f6e-3499-4d26-9a97-2cd6e03a5d0f"
  - "REQ-05cc6e6a-6440-429f-8447-16bd7b192d9c"
references:
  - "ADR-941d3900-029c-4806-bac8-79ae5e9df389"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:11:25+09:00"
---

# quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す

- ステータス: stable
- 日付: 2026-11-26
- 関連: [requirement に risk_exempt を設け、理由を書いた requirement を未カバーから外す](requirement-risk-exempt.md), [報告の指摘は success の item の警告で表し、働く強さは exit code で決める](report-findings-as-success-items-with-warnings.md), GitHub Issue #31, `docs/model.yaml`
- 起点: #31 の grilling（2026-11-26）で確定

## 背景

2026-11-26 の時点で、`quality` 27 本のうち 21 本がどの `infrastructure` にも `satisfies` されていなかった。
その中には、規範が誰を縛るかのように、人が内容を読んで判断するしかなく、仕組みで支えられないものがある。
これまでのモデルでは、仕組みで支えない理由を `quality` に記録できず、`sara-gap` はそうした規範を
未カバーとして出し続けていた。

## 決定

- `quality` に任意の text の `infrastructure_exempt` を足す。値は、`infrastructure` に `satisfies` されない
  理由の 1 文で、`requirement` の `risk_exempt` と同じ形にする
- `sara-gap` は `infrastructure_exempt` を持つ `quality` を未カバーから外し、`quality` の到達率の分母にも
  入れない。`infrastructure_exempt` を持つ有効な `quality`（`status` が `deprecated` でないもの。`draft` を
  含む）を情報として一覧にする
- 製品の `mitodoke gap` の要件にも同じことを書く
- 「支えの無い `quality` は理由を書く」規範を、新しい `quality` 1 本として起こし、検証基盤の
  `infrastructure` が `satisfies` する
- 新しい一覧も `gap` の情報の節で、`result.info` に置く。[報告の指摘は success の item の警告で表し、働く強さは exit code で決める](report-findings-as-success-items-with-warnings.md)
  は書き換えない。その決定（情報の節は item にせず `result.info` に置く）は変わらず、当てはまる一覧が
  1 つ増えるだけと読む

## 根拠

`risk_exempt` と同じ形なので、読む人が覚えることが増えない。欄の名前も `risk_exempt` と同じ組み立てで、
欠けている型の名前がそのまま入る。

要件にも書くのは、script と要件の食い違いを残さないためである。要件を直さないと、#6 の実装が要件に
従ったとき、`infrastructure_exempt` を書いた規範が再び欠けとして報告される。

規範を独立した `quality` にすると、欄の使い方が規範として残り、`status` が `draft` の item と使い分ける
決まりを書く場所ができる。既存の ADR を書き換えないのは、決定が変わっていないためである。

## 棄却した代替案

### 「レビュー」を表す infrastructure item を起こす

`infrastructure` を技術基盤と定めたモデルの定義から外れ、どの規範にも張れる item になって `satisfies` が
意味を失う。

### 理由を散文に書くだけにする

`sara-gap` の `quality` の節が 0 本にならず、完了を機械で確かめられない。

### 欄の名前を support_exempt にする

`support` という語がモデルに無く、何を免じるのかを本文で説明し直すことになる。

### 欄の名前を satisfies_exempt にする

`satisfies` を書くのが `infrastructure` の側で、`quality` の欄にすると向きが逆に読める。

### 要件は #6 の子の epic で直す

script と要件が食い違ったまま残り、#6 の実装が要件に従うと `infrastructure_exempt` を書いた規範が再び
欠けとして報告される。

### 既存の規範「規範の型は、それが誰を縛るかで決める」に文を加える

型の選び方の規範に別の決まりが入り、片方だけを変えにくくなる。

### 規範を書かず、モデルのコメントと ADR だけに残す

欄の使い方が規範として残らず、`draft` の item と使い分ける決まりを書く場所が無い。

### 既存の ADR を丸ごと書き直して supersedes を張る

決定が変わっていないのに ADR 1 本を書き直すことになり、変更が 100 行ほど増える。

### 既存の ADR の括弧の中だけを書き換える

規範が禁じる部分的な書き換えに当たる。

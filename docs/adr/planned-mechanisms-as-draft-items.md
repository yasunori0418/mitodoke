---
id: "ADR-85c9a1ed-9bcf-4134-9d47-7965d954ed7b"
type: adr
name: "まだ作っていない仕組みは、status が draft の item で表す"
description: "支える仕組みをまだ作っていない quality と test_plan は、status が draft の infrastructure と design で支えを表し、仕組みを作ったときに stable にする。"
section: authoring
status: stable
sources:
  - id: "issue-31"
    resource: "https://github.com/yasunori0418/mitodoke/issues/31"
    title: "epic: 規範とテスト計画を支える仕組みを決める — infrastructure に satisfies されていない quality と、test_plan の支え"
origin: "#31 の grilling（2026-11-26）で確定"
justifies:
  - "QA-cddaeec3-b9f7-458a-815a-6a14213557ed"
  - "INF-7d683bd6-5d87-48e7-ad50-2147dcfbe793"
  - "DSG-e6af0d04-58c4-4c32-83d9-7b0d02fb0dab"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:28:25+09:00"
---

# まだ作っていない仕組みは、status が draft の item で表す

- ステータス: stable
- 日付: 2026-11-26
- 関連: [quality に infrastructure_exempt を設け、理由を書いた quality を未カバーから外す](quality-infrastructure-exempt.md), GitHub Issue #31
- 起点: #31 の grilling（2026-11-26）で確定

## 背景

2026-11-26 の時点で、どの `infrastructure` にも `satisfies` されていない `quality` のうち 6 本は、支える
仕組みをまだ作っていなかった。rustfmt と clippy、カバレッジ、プラットフォームごとの検証、バージョンとタグ、
sara の版の揃え、workflow の権限で、どれも Rust のコードと CI を作る #6 で実現する。

`test_plan` 4 本は下流を持っていなかった。4 本は受け入れテストの実行の仕方を定めているが、それを実行する
仕組みはまだ無い。モデルでは `infrastructure` が `satisfies` できる先は `quality` と `design` だけで、
`test_plan` を `satisfies` できるのは `design` である。`test_plan` の支えは、`infrastructure` → `design` →
`test_plan` の 2 段でしか表せない。

## 決定

- まだ作っていない仕組みに支えられる `quality` 6 本のために、`status` が `draft` の `infrastructure` を
  1 本起こし、6 本を `satisfies` させる。本文に、何を作る予定か、今どこまで動いているかを書く
- `test_plan` 4 本のために、`status` が `draft` の `design` を 1 本起こして 4 本を `satisfies` させ、
  上の `infrastructure` がその `design` を `satisfies` する。`design` の本文には `test_plan` がすでに
  決めたことだけを書き、新しい設計の決定はしない
- #6 の子の epic が仕組みを作ったときに、詳細を書いて `stable` にする

## 根拠

何が支える予定かを今グラフに残せる。`draft` はモデルにすでにある値である。

`test_plan` にも同じ形を当てると、#31 の完了条件をこの決定の範囲で満たせ、`quality` の `draft` の扱いと
揃う。

## 棄却した代替案

### 6 本に infrastructure_exempt を書く

欄の意味が「仕組みで支えない」から「まだ無い」に広がり、作ったあとの消し忘れを機械で見つけられない。

### quality 6 本に何もしない

`sara-gap` の `quality` の節が 0 本にならず、#71 の完了条件を満たせない。

### design を起こさず、test_plan の支えを #6 の子の epic に回す

#31 の完了条件を変えることになり、どの仕組みが `test_plan` を支えるかの決定が #6 まで残らない。

### test_plan ごとに design を 1 本ずつ、計 4 本起こす

4 本とも同じ受け入れテストの仕組みを指して本文が重なる。

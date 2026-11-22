---
id: "ADR-a3f7a8a4-04f4-435c-b7c9-a1502787a089"
type: adr
name: "level が high の risk と、有効な solution と use_case に人の verified を求める"
description: "level が high の risk と、status が deprecated でない solution と use_case 自身に、generated.at 以降の human: の verified を求め、medium・low の risk と TC・CASE には求めない。"
section: verification
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定。level が high の risk に人の verified を求める ADR を書き直した"
justifies:
  - "QA-aa70fff6-3e0a-4163-bf4c-97f1730f7496"
supersedes:
  - "ADR-f27192ea-3ca8-4794-8a6a-805dd8ab323d"
references:
  - "ADR-05ab6fb0-899b-46e7-a853-82ed1b6857ff"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T16:41:38+09:00"
---
# level が high の risk と、有効な solution と use_case に人の verified を求める

- ステータス: stable
- 日付: 2026-11-22
- 関連: [level が high の risk に人の verified を求める](human-verified-required-for-high-risk.md), [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](upper-layers-validated-by-review-questions.md), GitHub Issue #80, `docs/model.md`
- 起点: issue #80 の grilling（2026-11-22）で確定。level が high の risk に人の verified を求める ADR を書き直した

## 背景

item の多くはエージェントが書き、`generated.by` はエージェントの actor になる。`verified` は人が
内容を確かめたときにだけ手で足す記録で、自動では付かない。

risk の `level` は likelihood と impact から導かれ、high は起きやすさと影響の組み合わせが最も重い
ものを表す。上位 2 層の `solution` と `use_case` は risk の `threatens` の先にならず、
[確認の問い](../ubiquitous-language/review-question.md)に人が答える
[妥当性確認](../ubiquitous-language/validation.md)でカバーする。

## 決定

次の item は `generated.at` 以降の `human:` の `verified` を持たなければならないとし、持たないものを挙げる。

- `level` が high の risk
- `status` が `deprecated` でない `solution` と `use_case`。`draft` の item も含む

決定の細目は次のとおりとする。

- `human:` の `verified` は、`by` が `human:` で始まり、`at` がその item の `generated.at` 以降の要素とする
- 対象は上の item 自身に限る。`status` が `deprecated` の item は対象から外す
- `solution` と `use_case` の人の確認は、型ごとの確認の問いに答えてから記録する
- 挙げた結果は報告に留める。件数を減らすために item を書き換えない

## 根拠

high の risk は、見積もりを誤ったときの損失が最も大きい。人が脅威の見立てを確かめる対象を、
level で機械的に決められる。

`solution` と `use_case` は保証する連鎖の上にあり、確かめる手段は人の妥当性確認だけである。
人の確認の記録が無ければ、その item を人が確かめたかどうかを読み取れない。

`generated.at` より前の `verified` は、その後に本文が変わっているので、いまの内容を確かめた
記録にならない。エージェントの actor の `verified` は書き手と同じ種類の読み手による確認で、
人の確認の代わりにならない。

## 棄却した代替案

### medium の risk まで広げる

medium の risk まで挙げると、high の risk の確認が埋もれる。medium の見立ての誤りは損失が
小さく、人の確認の手間に見合わない。

### risk の下流の test_condition と test_case にも求める

test_condition と test_case は risk に対処するテーマと実体で、数が多い。risk の見立てが確かめて
あれば、その下流が古い前提のまま残っていないかは、上流の relation を辿る鮮度の比較が挙げる。

### solution と use_case の verified を任意のままにする

上位 2 層は妥当性確認だけで確かめるので、記録を任意にすると、確かめていない item を見分けられない。

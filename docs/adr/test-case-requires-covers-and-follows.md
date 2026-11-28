---
id: "ADR-869eb0c8-d2a2-4e2f-9016-2e9a0c55e627"
type: adr
name: "test_case は covers と follows をそれぞれ 1 本以上持つ"
description: "test_case が covers と follows をそれぞれ 1 本以上持つことを構造の契約にし、欠けたら失敗にする。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q10）で確定"
justifies:
  - "REQ-3f258649-995e-404f-8bda-52fba8c0281d"
references:
  - "ADR-3f524795-70f3-4bca-ba25-ae1e40e94dd4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:02+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:00:49+09:00"
---
# test_case は covers と follows をそれぞれ 1 本以上持つ

- ステータス: stable
- 日付: 2026-11-17
- 関連: [test_case から test_plan へ follows を張る](test-case-follows-test-plan.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q10）で確定

## 背景

test_case は、どの test_condition を確かめるかを `covers` で、どのテスト計画に従うかを `follows`
で表す。sara の strict の検査は、test_case が `covers` か `follows` のどちらか 1 本を持てば
受け付ける。`covers` を消しても `sara check` は成功し、`covers` の欠けを見つける仕組みは
写した script にも無い。

sara は「この型はこの relation を必ず持つ」を model.yaml に書けない。コンセプト文書は、
test_plan から test_case、test_condition、risk へと辿るつながりを想定している（§5.2）。
test_case に両方の relation を求めるなら、mitodoke の側で検査するしかない。

## 決定

test_case は `covers` と `follows` をそれぞれ 1 本以上持つことを構造の契約にし、欠けたら
失敗にする。

## 根拠

test_case は、実装したテスト資産 1 つに 1 件ずつ起こす item である。test_condition と違い、
検討するだけで実行しないということが無い。何を確かめ、どの計画に従うかが書かれていない
test_case は、記述が足りていない。

検査の強さの分け方では、これはつながりの欠けではなく、test_case 自身の記述の欠けに当たる。
そのため、報告ではなく構造の契約として失敗にする。

## 棄却した代替案

### covers だけを必須にし、follows の欠けは報告にする

`follows` が無い test_case も、どの計画に従うかが書かれていない点で記述が足りていない。
`covers` と同じく test_case 自身の記述の欠けなので、`follows` だけを報告に留める理由が無い。

### 今のままにする

sara の接続漏れ（orphan）の検査だけに任せ、`covers` の欠けは検出せず、`follows` の欠けは
`sara-gap` の報告に任せる案。`covers` を欠いた test_case が `sara check` を通ってしまい、
何を確かめる test_case かが書かれていないことに気づく手段が無い。

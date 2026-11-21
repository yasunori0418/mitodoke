---
id: "ADR-c291c77e-7e40-4b89-a2c2-0dfec4c911f9"
type: adr
name: "OKF より厳しい 5 つの制約を構造の契約に引き継ぐ"
description: "写した ADR が OKF v0.2 に重ねて定めた 5 つの制約を、すべて mitodoke の構造の契約に引き継ぐ。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q38）で確定"
justifies:
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
references:
  - "ADR-9a646576-31bd-4cea-996d-54993ff2b8fa"
  - "ADR-7967c58b-2d03-40d6-89b4-680be30fa5d1"
  - "ADR-bab72f31-7cb1-47a3-bb2d-7876757d86fb"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:33:02+09:00"
---
# OKF より厳しい 5 つの制約を構造の契約に引き継ぐ

- ステータス: stable
- 日付: 2026-11-17
- 関連: [item に生成者・確認の記録・期限を持たせる](generated-verified-stale-after.md), [status を OKF の 3 値にし全ての型に持たせる](status-okf-values.md), [OKF v0.2 と互換の frontmatter キーを item に足す](okf-compatible-frontmatter.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q38）で確定

## 背景

写した ADR は、OKF v0.2 の frontmatter に、次の 5 つの必須化と制約を加えている。

- `verified` はリストでなければ違反にする。OKF は、1 つの mapping を 1 要素のリストとして扱う
  ことを、読み手の義務にしている
- `generated` を全 item で必須にし、`generated.at` に未来の時刻を書くことを禁じる。OKF では
  `generated` は任意
- 新しく起こす item では `description` を必須にする。OKF では推奨
- `status` を全ての型で必須にする。OKF では任意で、無ければ `stable`
- 人の確認として数えるのは、`generated.at` 以降の `verified` だけにする。OKF は `verified` と
  `generated.at` を独立に扱う

これらを mitodoke の構造の契約に引き継ぐかを決める必要があった。

## 決定

5 つすべてを構造の契約に引き継ぐ。

- `verified` はリストに限る。1 つの mapping は違反にする
- `generated` は全 item で必須にし、`generated.at` の未来の時刻を禁じる
- 新しく起こす item では `description` を必須にする
- `status` は全ての型で必須にする
- 人の確認は、`generated.at` 以降の `verified` だけを数える

mitodoke は、1 つの mapping を 1 要素のリストとして扱う OKF v0.2 の読み手の義務には沿わない。

## 根拠

`verified` を最初からリストだけに限るのは、利用者の判断による。1 つの mapping のときだけ
1 要素のリストとして扱うと、データの扱いのためにプログラムが複雑に分岐する。それを避け、
形を 1 つにして単純に保つ。

ほかの 4 つは、mitodoke の判定に欠かせない。

- `generated` が無い item や、時刻が未来の item があると、再確認待ちを判定できない（コンセプト
  文書 §7）
- 人の確認を `generated.at` 以降に限らないと、本文を変えたあとも古い確認が数えられてしまう
- `status` は「supersedes の先が deprecated か」の検査と、index.md の節に使う
- `description` は index.md の一覧に使う

受け入れた代償は、mitodoke が OKF v0.2 の読み手の義務に沿わないことである。1 つの mapping の
`verified` を書いた文書は、OKF の読み手としては正しくても、mitodoke では違反になる。

## 棄却した代替案

### 1 つの mapping の verified を 1 要素のリストとして受け付け、ほかの 4 つは引き継ぐ

推奨だった案。OKF が読み手の義務としている読み方だけを合わせる。受け付けても判定は変わらず、
`human:` 以外の `verified` を OKF に合わせて受け付ける方針とも揃う。採らなかったのは、
1 つの mapping のときだけ別に扱うと、プログラムが複雑に分岐するためである。

### OKF に重ねた必須化と制約をすべて外し、OKF に合わせる

`generated` が無い item で再確認待ちを判定できず、古い確認が数えられ、supersedes の検査と
index.md の節と一覧が成り立たなくなる。

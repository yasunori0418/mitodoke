---
id: "ADR-21e51aa5-fdad-4aad-b52d-23bb22fd2961"
type: adr
name: "OKF より厳しい 5 つの制約を引き継ぎ、description は起票で拒み、verified の数え方は違反の条件にしない"
description: "OKF v0.2 に重ねた 5 つの制約を引き継ぎ、description の欠けは mitodoke new が起票を拒むことで検査して check では違反にせず、generated.at 以降の verified だけを人の確認に数える規則は違反の条件を持たない数え方にする。"
section: inspection
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 7 節（description を必須にする検査の時点、verified の数え方の違反の条件）"
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "issue #72 の grilling（2026-11-22）で確定。OKF より厳しい 5 つの制約を構造の契約に引き継ぐ ADR を書き直した"
justifies:
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
supersedes:
  - "ADR-c291c77e-7e40-4b89-a2c2-0dfec4c911f9"
references:
  - "ADR-996af7b5-ed7c-4bb6-826f-0de50052f53e"
  - "ADR-7967c58b-2d03-40d6-89b4-680be30fa5d1"
  - "ADR-bab72f31-7cb1-47a3-bb2d-7876757d86fb"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:22:37+09:00"
---
# OKF より厳しい 5 つの制約を引き継ぎ、description は起票で拒み、verified の数え方は違反の条件にしない

- ステータス: stable
- 日付: 2026-11-22
- 関連: [OKF より厳しい 5 つの制約を構造の契約に引き継ぐ](stricter-than-okf-constraints-kept.md), [item に生成者・確認の記録・期限のフィールドを持たせる](generated-verified-stale-after-fields.md), [status を OKF の 3 値にし全ての型に持たせる](status-okf-values.md), [OKF v0.2 と互換の frontmatter キーを item に足す](okf-compatible-frontmatter.md), GitHub Issue #72, GitHub Issue #6, GitHub Issue #4
- 起点: issue #72 の grilling（2026-11-22）で確定。OKF より厳しい 5 つの制約を構造の契約に引き継ぐ ADR を書き直した

## 背景

写した文書管理の仕組み（ADR・規範・契約テスト）は、OKF v0.2 の frontmatter に、次の 5 つの
必須化と制約を加えている。

- `verified` はリストでなければ違反にする。OKF は、1 つの mapping を 1 要素のリストとして扱う
  ことを、読み手の義務にしている
- `generated` を全 item で必須にし、`generated.at` に未来の時刻を書くことを禁じる。OKF では
  `generated` は任意
- 新しく起こす item では `description` を必須にする。OKF では推奨
- `status` を全ての型で必須にする。OKF では任意で、無ければ `stable`
- 人の確認として数えるのは、`generated.at` 以降の `verified` だけにする。OKF は `verified` と
  `generated.at` を独立に扱う

5 つすべてを構造の契約に引き継ぐと決めた時点では、次の 2 点が決まっていなかった（#6 のコメントの 7 節）。

- `description` の必須化の「新しく起こす item」を、どう見分けるか。ある時点の文書だけでは判定できない。
  どのサブコマンドのどの時点で検査するかも決まっていない
- 「`generated.at` 以降の `verified` だけを人の確認に数える」を構造の契約に入れたが、どの状態を違反に
  するかを定めていない

## 決定

5 つの制約をすべて引き継ぐ。

- `verified` はリストに限る。1 つの mapping は構造の契約の違反にする
- `generated` は全 item で必須にし、`generated.at` の未来の時刻を禁じる。構造の契約として検査する
- `description` の欠けは、`mitodoke new` が `description` の無い起票を拒むことで検査する。`mitodoke check`
  は、既存の item の `description` の欠けを違反にしない
- `status` は全ての型で必須にする。構造の契約として検査する
- 人の確認は、`generated.at` 以降の `verified` だけを数える。これは違反の条件を持たない数え方の規則で、
  `generated.at` より前の `verified` の要素があっても違反にしない

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

`description` の欠けを起票のときに拒めば、新しく起こした item かどうかを、ある時点の文書から見分ける
必要が無くなる。起票のときには、起こす item が新しいことが分かっている。

`generated.at` より前の `verified` の要素は、本文を変える前の確認の記録である。いまの本文を確かめた
記録にならないので人の確認には数えないが、記録として残っていることは誤りではない。数え方の規則に
すれば、本文を書き換えたあとに古い要素を消さなくてよい。

受け入れた代償は、mitodoke が OKF v0.2 の読み手の義務に沿わないことである。1 つの mapping の
`verified` を書いた文書は、OKF の読み手としては正しくても、mitodoke では違反になる。

## 棄却した代替案

### check が基準のリビジョンと比べ、新しく加えた item の description の欠けを違反にする

ある時点の文書だけでは、新しく加えた item かどうかを見分けられず、基準のリビジョンとの比較が要る。起票の
ときに拒めば、起こす item が新しいことが分かっているので、見分ける必要が無い。#6 のコメントが挙げた検査の
時点の候補のうち、起票のときに拒む案を選んだ。

### 1 つの mapping の verified を 1 要素のリストとして受け付け、ほかの 4 つは引き継ぐ

推奨だった案。OKF が読み手の義務としている読み方だけを合わせる。受け付けても判定は変わらず、
`human:` 以外の `verified` を OKF に合わせて受け付ける方針とも揃う。採らなかったのは、
1 つの mapping のときだけ別に扱うと、プログラムが複雑に分岐するためである。

### OKF に重ねた必須化と制約をすべて外し、OKF に合わせる

`generated` が無い item で再確認待ちを判定できず、古い確認が数えられ、supersedes の検査と
index.md の節と一覧が成り立たなくなる。

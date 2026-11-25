---
id: "ADR-1f4b4f98-9402-48e6-8e90-e3499c970d94"
type: adr
name: "mitodoke 自身の手順書とテストチャーターを tests/manual/ の下に置く"
description: "mitodoke 自身の手順書を tests/manual/procedures/ に、テストチャーターを tests/manual/charters/ に置き、テスト資産の一覧には列挙のコマンドで載せ、ディレクトリは最初のファイルを置くときに作る。"
section: risk-test-defect
status: stable
sources:
  - id: "issue-75-decisions"
    resource: "https://github.com/yasunori0418/mitodoke/issues/75#issuecomment-7132739249"
    title: "#75 の grilling の決定（2026-11-24）"
origin: "issue #75 の grilling（2026-11-24）で確定"
justifies:
  - "TP-8c2f612e-bc08-438f-a6cd-9b73028084b7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-25T00:07:41+09:00"
---
# mitodoke 自身の手順書とテストチャーターを tests/manual/ の下に置く

- ステータス: stable
- 日付: 2026-11-24
- 関連: [テスト系 item を CASE・TC・RISK の 3 段で起こし、人が行うテストも CASE にして、手順書とテストチャーターは列挙のコマンドからも一覧に載せる](test-items-in-three-tiers-with-human-tests-from-any-source.md), [テスト資産の列挙は内蔵せず、設定のコマンドかコミットしたファイルから読む](test-assets-listed-by-configured-sources.md), GitHub Issue #75
- 起点: issue #75 の grilling（2026-11-24）で確定

## 背景

手順書とテストチャーターの置き場所は、設定に持たず、製品が自分で決める。手順書とテストチャーターも、
ほかのテスト資産と同じく、設定に書いた列挙のコマンドの出力か、コミットした一覧のファイルから、
テスト資産の一覧に載せる。

mitodoke 自身が手順書とテストチャーターをどこに置き、何から一覧に載せるかを決める必要があった。

## 決定

mitodoke 自身の手順書は `tests/manual/procedures/` に、テストチャーターは `tests/manual/charters/` に置く。
テスト資産の一覧には列挙のコマンドで載せる。ディレクトリは最初のファイルを置くときに作る。

## 根拠

手順書とテストチャーターはテスト資産で、item ではない。`docs/` の下に置くと、sara が走査する範囲に
item でない Markdown が増える。

テストコードは `tests/` の下に置く見込みである。手順書とテストチャーターも `tests/` の下に置けば、
テスト資産が 1 つのディレクトリの下に集まる。

区分は `test_case` の置き場所（`docs/test/<区分>/`）から導くので、手順書の側を区分で分ける必要が無い。

一覧のファイルは人が 1 行ずつ書くので、手順書を追加して書き忘れると、`test_case` の無い手順書を検査が
見つけられない。列挙のコマンドを使えば、置き場所の下のファイルを毎回並べ直せる。

## 棄却した代替案

### 区分のディレクトリに置く

`docs/test/<区分>/` に、`test_case` と並べて置く案。`test_case` と手順書が隣に並ぶが、区分の
ディレクトリに item でないファイルが入る。

### docs の下に分けて置く

`docs/test-procedures/` と `docs/test-charters/` に置く案。文書はすべて `docs/` の下に集まるが、sara が
走査する範囲に入る。

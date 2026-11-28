---
id: "ADR-a8ba58e1-b92b-481a-b566-49d9b303dcd9"
type: adr
name: "model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる"
description: "適用先の製品の model.yaml は mitodoke の設定ファイルから生成してコミットし、生成結果との差分が無いことを CI で確かめる。"
section: model-config
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q2）で確定"
justifies:
  - "REQ-76368939-a62b-47cb-b334-8bd7d7ee8389"
references:
  - "ADR-2457aa00-fab7-4c99-af53-2e6643c21c79"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:29:13+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:33:41+09:00"
---
# model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる

- ステータス: stable
- 日付: 2026-11-17
- 関連: [model.yaml で組み込みモデルを全面置換し、汎用の型名を使う](model-yaml-full-replacement.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q2）で確定

## 背景

mitodoke は、適用先の製品のリポジトリへ sara の model.yaml を渡す必要がある。sara はスキーマを
全面置換でしか変えられず、model.yaml の enum は外部のファイルを参照できない。そのため、テストの
区分や section の値のように適用先の製品ごとに違う値を手で書く形では、同じ値を model.yaml と、
index の見出しやテストの区分の表に重ねて書くことになる。model.yaml をどう渡し、適用先の製品が
どこまで変えられるようにするかを決める必要があった。

## 決定

適用先の製品の model.yaml は、mitodoke の設定ファイルから生成する。設定ファイルには、テストの
区分、型ごとの section の値と見出し、使う言語を書く。型は選ばないので、使う型は書かない
（[組み込みの型を 12 型にし、すべて必須にする](twelve-builtin-types-all-required.md)）。

生成した model.yaml はコミットし、設定ファイルから生成し直した結果と差分が無いことを CI で
確かめる。sara.toml も同じく設定ファイルから生成して確かめる（形式とあわせて
[設定ファイルを mitodoke.yaml にし、独自の定義は sara の model.yaml と同じ書き方にする](config-file-mitodoke-yaml.md)
で決めた）。

## 根拠

テストの区分と section の値を設定ファイルの 1 か所に集めれば、model.yaml・index の見出し・
テストの区分の表の 3 か所に同じ値を書く必要がなくなる。生成物をコミットして差分を確かめる扱いは、
生成した index.md と同じである。

model.yaml を生成物にしておけば、mitodoke を新しい版に上げたときに適用先の製品の model も追従し、
CLI は model の語彙を前提にできる。

この案の弱点は、設定で表せない独自の型やフィールドを追加する手段が別に要ることである。その手段は
[独自の型・relation・フィールドは追加だけを許す](custom-definitions-additive-only.md) で決めた。

## 棄却した代替案

### 雛形の model.yaml を複製し、その後は適用先の製品が自由に書き換える

mitodoke を新しい版に上げても、適用先の製品の model が追従しない。CLI が model の語彙を前提に
できなくなる。

### 1 つの model.yaml を固定で配り、適用先の製品には変えさせない

適用先の製品ごとに値を変えられないので、section を失う。

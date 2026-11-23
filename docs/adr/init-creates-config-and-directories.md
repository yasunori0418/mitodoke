---
id: "ADR-80d1238a-f2ba-4c39-8213-22263a92d91a"
type: adr
name: "init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、規範は複製しない"
description: "mitodoke init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、mitodoke.yaml があれば上書きせずに拒み、文書管理の規範は複製せず、model.yaml と sara.toml は model に生成させる。"
section: commands
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 6 節（適用先の製品への導入）"
origin: "issue #72 の grilling（2026-11-22）で確定"
justifies:
  - "REQ-ba6cb998-94a0-4806-bd9a-db9a83484991"
references:
  - "ADR-34e97b34-98a3-4e2a-a24b-c21bf86d05dd"
  - "ADR-d252b2c6-d54a-40a7-9d0b-3658b333d1dc"
  - "ADR-a8ba58e1-b92b-481a-b566-49d9b303dcd9"
  - "ADR-f900c722-23d9-4dcb-8407-97b4eb98b92a"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:05:48+09:00"
---
# init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、規範は複製しない

- ステータス: stable
- 日付: 2026-11-22
- 関連: [サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける](subcommands-split-with-init.md), [規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する](norms-kept-in-own-repository.md), [model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md), [型と置き場所の一致を構造の契約にし、型ごとの置き場所を設定に持つ](type-location-match-is-structural-contract.md), GitHub Issue #72, GitHub Issue #6
- 起点: issue #72 の grilling（2026-11-22）で確定

## 背景

適用先の製品に mitodoke を導入する手順には、初期の `mitodoke.yaml`・model.yaml・`sara.toml`・ディレクトリを
用意する手段が無かった（#6 のコメントの 6 節）。mitodoke には use_case
[自分の製品に導入し、構成に合わせて設定する](../use-cases/adopt-and-configure-for-own-product.md) と要件
[製品は CLI・モデル・文書管理の規範・スキル・欠陥運用の規範を含む](../requirements/product-contents.md) があるが、
導入のはじめに何を用意するかを定めた item は無い。

サブコマンドに初期化の `init` を加えると決めたので
（[サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける](subcommands-split-with-init.md)）、
`init` が何を作り、何を作らないかを決める必要があった。

## 決定

`mitodoke init` は、初期の `mitodoke.yaml` と、設定が型ごとに持つ置き場所のディレクトリを作る。

- `mitodoke.yaml` がすでにあるときは、上書きせずに拒む
- mitodoke の文書管理の規範は、適用先の製品へ複製しない
- model.yaml と `sara.toml` は `init` では作らず、`model` が生成する

## 根拠

- 型ごとの置き場所は設定に持ち、item の型と置き場所の一致は構造の契約になる
  （[型と置き場所の一致を構造の契約にし、型ごとの置き場所を設定に持つ](type-location-match-is-structural-contract.md)）。
  `init` が設定と同じ表から置き場所のディレクトリを作れば、作ったディレクトリは設定と一致する
- すでにある `mitodoke.yaml` は、利用者が自分の製品の構成と運用に合わせて書き換えた設定である。上書きすると、
  その設定が失われる
- 規範は mitodoke のリポジトリ自身で管理し、適用先の製品は写さずに参照すると決めている
  （[規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する](norms-kept-in-own-repository.md)）。
  規範を複製すると、mitodoke のバージョンを上げたときに適用先の写しが古いまま残る
- model.yaml と `sara.toml` は設定ファイルから生成するものである
  （[model.yaml を設定ファイルから生成してコミットし、差分が無いことを確かめる](model-generated-from-config.md)）。
  `init` が作ると、同じ生成を 2 つのサブコマンドが持つことになる

## 棄却した代替案

### 規範を雛形の item として、初期化のコマンドで適用先の製品へ複製する

[規範は mitodoke のリポジトリ自身で管理し、適用先は写さず参照する](norms-kept-in-own-repository.md) が棄却した案で、
use_case [文書管理の規範を、初期化のコマンドで適用先の製品へ複製する](../use-cases/norms-copied-by-init-command.md)
として記録している。mitodoke のバージョンを上げたときに、適用先の写しが古いまま残る。

### init が model.yaml と sara.toml も作る

model.yaml と `sara.toml` は、設定ファイルから `model` が生成する。`init` も作ると、同じ生成を 2 つの
サブコマンドが持つことになるので採らなかった。

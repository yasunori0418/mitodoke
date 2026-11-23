---
id: "ADR-34e97b34-98a3-4e2a-a24b-c21bf86d05dd"
type: adr
name: "サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける"
description: "mitodoke の CLI のサブコマンドを、初期化の init と、開発に使う script の名前から接頭辞を外した 9 つの、合わせて 10 個にし、すべてに --json を持たせ、index と model の --check は差分があれば exit code 1 で終える。"
section: commands
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
  - id: "issue-6-comment"
    resource: "https://github.com/yasunori0418/mitodoke/issues/6#issuecomment-7064704024"
    title: "#6 のコメントの 6 節（index と model の --check の結果、適用先の製品への導入）"
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "issue #72 の grilling（2026-11-22）で確定。サブコマンドを 9 つに分ける ADR を書き直した"
justifies:
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
supersedes:
  - "ADR-7bef3ffc-d2db-4da1-98d0-3678f57c3ea6"
references:
  - "ADR-f3d7ea3d-2959-41ec-8170-9678815196d0"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:46:02+09:00"
---
# サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける

- ステータス: stable
- 日付: 2026-11-22
- 関連: [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](single-cli-with-subcommands.md), [サブコマンドを new・gap・fresh・index・matrix・model・verify・export・check に分ける](subcommands-split-by-function.md), GitHub Issue #72, GitHub Issue #6, GitHub Issue #4
- 起点: issue #72 の grilling（2026-11-22）で確定。サブコマンドを 9 つに分ける ADR を書き直した

## 背景

mitodoke の開発では、起票・つながりの欠けの報告・再確認待ちの報告・index.md の生成・対応表の生成を、
`sara-new`・`sara-gap`・`sara-fresh`・`okf-index`・`test-doc-matrix` という別々の script で行っている。
CLI は script の機能に加えて、設定からの model.yaml の生成、人の確認の記録、item の一覧の JSON の出力、
検査をまとめて実行する機能を持つ。これらを 1 つの CLI のサブコマンドとして、どういう名前でどう分けるかを
決める必要がある。スキルは script の名前で手順を書いているので、名前の決め方はスキルの書き換えの量にも関わる。

サブコマンドを 9 つに分けた時点では、次の 3 点が欠けていた（#6 のコメントの 6 節）。

- 適用先の製品へ導入するときに、初期の `mitodoke.yaml` とディレクトリを用意する手段が無い
- `--json` を持つのは「報告と生成のサブコマンド」としていたが、どのサブコマンドが当たるかを決める条件が無い
- `index` と `model` の `--check` で差分があったときに、失敗にするかが決まっていない

## 決定

サブコマンドは `mitodoke init`・`new`・`gap`・`fresh`・`index`・`matrix`・`model`・`verify`・`export`・`check`
の 10 個とする。`init` 以外は今の script の名前から `sara-` などを外した名前で、機能ごとに分ける。

- `init` は、初期の設定ファイルとディレクトリを生成する
- すべてのサブコマンドは `--json` を持つ
- `index` と `model` は、生成した結果とコミットされたファイルの差分を確かめる `--check` を持ち、差分があれば
  exit code 1 で終わる
- `check` は、構造の契約・つながりの欠け・見直しの義務の検査をまとめて実行し、設定の強さで失敗か報告かを決める

サブコマンドごとの機能は、[サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md) が定める。

## 根拠

- 今の script と名前が 1 対 1 で対応するので、スキルの書き換えは、`sara-new` を `mitodoke new` に置き換えるように名前を置き換えることが中心になる。ただし、スキルが JSON を読む箇所では、名前に加えて読むパスも直す
- 今の script を確かめるテストを、対応するサブコマンドにそのまま当てられる
- 動詞でまとめても、サブコマンドの数は減らず、打つ語が 1 つ増えるだけである
- use_case [自分の製品に導入し、構成に合わせて設定する](../use-cases/adopt-and-configure-for-own-product.md) は、導入のはじめに初期化のコマンドで初期の設定ファイルと置き場所のディレクトリを用意することを求める。今の script にこの機能は無いので、script の名前に対応しないサブコマンドを `init` として 1 つ加える
- 要件 [サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない](../requirements/json-outturn-envelope.md) は、すべてのサブコマンドが `--json` を選んだときに結果エンベロープを出すと定めている。`--json` を「報告と生成のサブコマンド」に限ると、どのサブコマンドが当たるかを読み手が決めなければならず、この要件とも食い違う
- `index` と `model` の差分は CI で確かめる。差分を exit code で返さなければ、差分があっても CI の job は失敗しない。写した `okf-index.sh --check` も、食い違いがあれば exit code 1 で終わる

## 棄却した代替案

### 報告と生成を動詞でまとめる

報告を `mitodoke report gap`・`mitodoke report fresh`、生成を `mitodoke generate index`・`generate matrix`・`generate model` にまとめ、`init`・`new`・`verify`・`export`・`check` はそのままにする案。サブコマンドの数は減らず、打つ語が 1 つ増えるだけなので採らなかった。今の script との名前の対応も崩れる。

---
id: "ADR-7950f7a8-ecc6-4045-bf82-19317aef497e"
type: adr
name: "実行中に呼ぶ外部のプロセスは、git と設定のコマンドだけにする"
description: "mitodoke が実行中に呼ぶ外部のプロセスを git と設定ファイルに書かれたコマンドだけにし、sara は crate として組み込み、flake で一緒に配る sara の CLI は呼ばない。"
section: product-scope
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
references:
  - "ADR-f3d7ea3d-2959-41ec-8170-9678815196d0"
  - "ADR-7707ddc2-ee32-49a1-9316-918fe860394c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:53:02+09:00"
---
# 実行中に呼ぶ外部のプロセスは、git と設定のコマンドだけにする

- ステータス: stable
- 日付: 2026-11-23
- 関連: [検査・起票・生成を 1 つの CLI のサブコマンドとして持つ](single-cli-with-subcommands.md), [Nix flake を主な配布にし、sara の CLI を同じタグで一緒に配る](distributed-by-nix-flake-with-sara-cli.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

要件は、CLI が外部のツールに任せる仕事を「sara や git のように」と例で示すだけで、一覧を閉じていな
かった。mitodoke は sara-core を crate として組み込む。一方で、sara の CLI は mitodoke と同じタグの
ものを flake で一緒に配る。配ることと、実行中に呼ぶことが、区別されていなかった。

## 決定

mitodoke が実行中に呼ぶ外部のプロセスは、git と、設定ファイルに書かれたコマンドだけにする。設定ファイルに
書かれたコマンドは、人の識別子を取るコマンド、テスト資産を列挙するコマンド、`verify` のビューアと
エディタである。

sara は crate として組み込む。sara の CLI は、組み込む sara-core と同じタグのものを flake で一緒に配るが、
mitodoke はそれを呼ばない。

## 根拠

一覧を閉じれば、mitodoke を動かすのに要る実行ファイルが決まり、どの外部のプロセスの結果が出力に効くかを
読み取れる。

git は外部のプロセスとして呼ぶ。merge-base や改名の追跡で、利用者が手元で使う git の CLI と結果が
食い違わない。

sara の CLI は、利用者が mitodoke と同じ版の検証を手で回せるように配る。mitodoke は sara-core を
組み込むので、実行中に sara の CLI を呼ぶ理由が無い。

## 棄却した代替案

### git も crate（libgit2 の束縛など）で組み込み、外部のプロセスを設定のコマンドだけにする

git の実行ファイルが無くても動くが、依存が増え、merge-base や改名の追跡で git の CLI と結果が食い違いうる。

---
id: "ADR-4c874628-3899-42e4-9627-4de82605ed11"
type: adr
name: "エンベロープの subject は固定の documents 1 つにする"
description: "エンベロープの results[] の要素を常に 1 つにし、subject.name を固定の文字列 documents にする。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
references:
  - "ADR-4de11190-40c0-442d-890b-ed92f3c786b9"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:55:23+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:26:40+09:00"
---
# エンベロープの subject は固定の documents 1 つにする

- ステータス: stable
- 日付: 2026-11-23
- 関連: [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](json-output-conforms-to-outturn.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

outturn は、`results[]` の要素ごとに `subject.name` を必須にし、1 つのエンベロープの中で一意にすることを
求めている。`subject` は item の `id` の導出に関わらない。layat は `subject.name` に設定の名前を置いて
いる。mitodoke は、1 回の実行で 1 つのドキュメントグラフだけを扱う。

## 決定

エンベロープの `results[]` の要素は常に 1 つにし、`subject.name` は固定の文字列 `documents` にする。

## 根拠

1 回の実行で扱うグラフは 1 つなので、`results[]` を分ける理由が無い。`subject.name` を固定にすれば、item を
参照するときの組（ツール名、`subject`、`id`）が、実行した場所や計算機によらず同じになる。

読んだ設定ファイルのパスは、トップレベルの `info` に記録するので、`subject` に置かなくても実行を見分け
られる。

## 棄却した代替案

### `subject.name` に読んだ設定ファイルのパスを置く

1 つのリポジトリに設定が複数あるときに実行を見分けられるが、絶対パスは計算機ごとに違い、相対パスは作業
ディレクトリで変わる。

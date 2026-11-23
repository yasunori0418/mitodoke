---
id: "ADR-c878c66c-7514-408a-be81-9cfbff159738"
type: adr
name: "item は sara-core の読み込みが返したファイルとし、mitodoke は自分で走査しない"
description: "item を sara-core の読み込み（parse_directory）が item として返したファイルとし、mitodoke は自分でディレクトリを走査しない。"
section: product-scope
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T18:58:00+09:00"
---
# item は sara-core の読み込みが返したファイルとし、mitodoke は自分で走査しない

- ステータス: stable
- 日付: 2026-11-23
- 関連: GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

mitodoke のサブコマンドは、どれもドキュメントグラフの item を読む。何を item とみなすかを決めていない
と、サブコマンドや sara の CLI の間で、item の集合が食い違いうる。

issue #73 の調査では、frontmatter に `type:` を持つ `.md` の集合と、sara の item の集合が、mitodoke と
layat の有効なグラフで一致した。

## 決定

item は、sara-core の読み込み（`parse_directory`）が item として返したファイルとする。mitodoke は、自分で
ディレクトリを走査しない。`.gitignore` に一致する追跡済みのファイルも、sara が読むなら item である。

## 根拠

走査を sara-core に任せれば、mitodoke と sara の CLI で item の集合が食い違わない。mitodoke は sara-core を
組み込むので、同じ読み込みの結果を検証にもそのまま使える。issue #73 で、2 つのグラフについて、今の走査の
規則で困らないことを確かめた。

`.gitignore` で item を外す規則を mitodoke が足すと、sara の CLI と item の集合が食い違う。

## 棄却した代替案

### mitodoke が自分で `docs/` を走査して frontmatter を読み、sara-core には item を渡すだけにする

走査の規則を mitodoke が決められるが、sara の CLI と item の集合が食い違いうる。

---
id: "ADR-0f884c6d-5be5-4b57-8ae1-473fbfed76d9"
type: adr
name: "frontmatter を読む層を 1 つ持ち、読み込みを 1 つにまとめる"
description: "frontmatter を YAML として読む層を 1 つ持ち、sara-core が返した item と読み飛ばしたファイルだけを読み、どのサブコマンドもこの 2 つを合わせた 1 つの読み込みの結果を使う。"
section: product-scope
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
references:
  - "ADR-c878c66c-7514-408a-be81-9cfbff159738"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:15:54+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:55:37+09:00"
---
# frontmatter を読む層を 1 つ持ち、読み込みを 1 つにまとめる

- ステータス: stable
- 日付: 2026-11-23
- 関連: [item は sara-core の読み込みが返したファイルとし、mitodoke は自分で走査しない](items-are-files-returned-by-sara-core-loader.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

OKF のキー（`generated`・`verified`・`stale_after`・`sources`）と、宣言の無いキーは、sara-core が返す item
（`Item`）に入らない。mitodoke はこれらを検査し、`generated` と `verified` を書く。

issue #73 の調査で、sara-core の編集（`EditService`）は入れ子の `verified` を書けず、生の frontmatter
（`RawFrontmatter`）も使えないことが分かった。

## 決定

frontmatter を YAML として読む層を 1 つ持つ。この層は、sara-core が返した item のファイルと、読み飛ばした
ファイルだけを読む。

どのサブコマンドも、sara-core の読み込みの結果と、この層の結果を合わせた、1 つの読み込みの結果を使う。
frontmatter を別の読み方で読む箇所を作らない。

## 根拠

sara-core の `Item` に入らないキーを読むには、mitodoke が frontmatter を自分で読むしかない。sara-core の
編集の仕組みでは入れ子の `verified` を書けないので、書く側も mitodoke が持つ。

読む層を 1 つにし、読むファイルを sara-core が返したものと読み飛ばしたものに限れば、item の集合は
sara-core の読み込みと同じままになる。読み飛ばしたファイルも読むので、なぜ読めないかを示せる。

どのサブコマンドも同じ読み込みの結果を使えば、サブコマンドの間で、同じ item の読み方が食い違わない。

## 棄却した代替案

### mitodoke が自分で `docs/` を走査して frontmatter を読み、sara-core には item を渡すだけにする

走査と読み方を mitodoke が 1 か所で決められるが、sara の CLI と item の集合が食い違いうる。

---
id: "ADR-02a75db6-70cd-4fca-bc17-ae8918c4cafd"
type: adr
name: "避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる"
description: "用語の避ける綴りの検査を mitodoke に内蔵せず、mitodoke の JSON 出力を使って適用先の製品が検査を組み立てる。"
section: inspection
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q12）で確定"
justifies:
  - "REQ-f78bd468-dd61-4564-9287-aec3a8ad6ba4"
references:
  - "ADR-aa5502df-77b9-41cc-94e9-1480ab6500ce"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:23:15+09:00"
---
# 避ける綴りの検査は内蔵せず、JSON 出力から適用先が組み立てる

- ステータス: stable
- 日付: 2026-11-17
- 関連: [export は sara 0.12 の items\[\] の形を写して固定し、OKF のキーを加える](export-shape-fixed-from-sara-items.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q12）で確定

## 背景

ubiquitous_term は、使わない綴りを `avoid` に持つ。`avoid` の綴りが文書の本文に無いことの
検査を、mitodoke がどう実装するかを決める必要があった。

写した `dev/tests/term-avoid.sh` は、実行のたびに `sara check --format json` の出力から prh の
辞書と textlint の設定を一時的に作り、textlint と textlint-rule-prh で検査している。prh の
機能のうち使っているのは、綴りが一致するかを調べる機能だけである。

## 決定

mitodoke は、避ける綴りの検査を内蔵せず、textlint も呼ばない。mitodoke の JSON 出力（用語の
一覧と `avoid`）を使って、適用先の製品が検査を組み立てる。例として、textlint と prh の組み方を
README などで案内する。

## 根拠

利用者の案による。JSON 出力から辞書と設定を作って検査する形は、写した `term-avoid.sh` で
すでに動いている。この script を mitodoke の JSON 出力を読む形に直せば、README で案内する例
そのものになる。

この決定で、mitodoke の JSON 出力は、外部のツールと連携する口になる。

## 棄却した代替案

### CLI の中で実装する

Markdown を解析し、コードを除いた本文で `avoid` の綴りを探す案。textlint と prh には依存しない。
利用者は、検査を内蔵せず、JSON 出力から外で組み立てる形を選んだ。外で組み立てる形は
写した `term-avoid.sh` ですでに動いているので、検査を製品に取り込まなかった。

### textlint と prh を外部ツールとして残し、CLI から呼ぶ

適用先の製品に、Node の実行環境と textlint を求めることになる。

### この検査を製品から外す

記録には、この案に固有の不採用の理由は無い。利用者は、検査を製品から外すのではなく、
JSON 出力から適用先の製品が組み立てる形を選んだ。

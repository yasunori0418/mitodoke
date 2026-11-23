---
id: "ADR-d9fcb647-d672-4925-be78-fc5f47154b02"
type: adr
name: "item を指定しない verify は、対話で選んだ枝を上流から順にたどり、ビューアとエディタを設定で選べる"
description: "item を指定しない mitodoke verify は、対話で枝を選ばせて上流から順に item を表示し、人の確認を記録する。表示のビューアとコメントのエディタは mitodoke.yaml で設定でき、コメントの行き先と自動のコミットは決めない。"
section: commands
status: stable
sources:
  - id: "issue-72"
    resource: "https://github.com/yasunori0418/mitodoke/issues/72"
    title: "cli-upstream: 1 use_case と requirement を見直し、欠けている要件を起こす"
origin: "issue #72 の grilling（2026-11-22）で確定"
justifies:
  - "REQ-423d8274-73e8-41d7-93d0-72bb4972e1c0"
references:
  - "ADR-34e97b34-98a3-4e2a-a24b-c21bf86d05dd"
  - "ADR-118fc416-3137-43b9-ab5b-49899dd4b2dc"
  - "ADR-05ab6fb0-899b-46e7-a853-82ed1b6857ff"
  - "ADR-dfff5637-f0a4-4e5d-a57e-f4dd1e7dbb42"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:50:23+09:00"
---
# item を指定しない verify は、対話で選んだ枝を上流から順にたどり、ビューアとエディタを設定で選べる

- ステータス: stable
- 日付: 2026-11-22
- 関連: [サブコマンドを init・new・gap・fresh・index・matrix・model・verify・export・check に分ける](subcommands-split-with-init.md), [verify は、端末で人が確認を入力したときだけ確認の記録を書く](verify-records-human-only-from-terminal.md), [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](upper-layers-validated-by-review-questions.md), [鮮度は上流の relation を辿って下流へ伝播させる](freshness-propagates-along-upstream-relations.md), GitHub Issue #72
- 起点: issue #72 の grilling（2026-11-22）で確定

## 背景

`mitodoke verify <item>` は、指定した 1 本の item に人の確認を記録する
（[verify は、端末で人が確認を入力したときだけ確認の記録を書く](verify-records-human-only-from-terminal.md)）。
use_case [上流の変更で再確認が要る成果物を知り、人の確認を記録する](../use-cases/review-stale-artifacts-and-record-verification.md)
は、これに加えて、確認する item を指定せずに始め、対話で枝を選んで、上流から順に item を読みながら人の確認を
記録できることを求める。

着手の時点で、`solution` 1 本と `use_case` 5 本はどれも `verified` を持たない。item を指定しない `verify` の
振る舞いと、その設定で変えられる範囲を決める必要があった。

## 決定

item を指定しない `mitodoke verify` は、対話で枝を選ばせ、上流から順に item を表示して、人の確認を記録する。

- item の表示に使うビューアと、コメントの入力に使うエディタは、`mitodoke.yaml` で設定できる
- 確認を記録するときに、人はコメントを入力できる
- コメントの行き先と、記録をコミットまで自動でするかは、この ADR では決めない

## 根拠

- 下流の item は上流の item を前提に書かれる
  （[鮮度は上流の relation を辿って下流へ伝播させる](freshness-propagates-along-upstream-relations.md)）。
  上流から順に読めば、下流を読むときには、その前提の上流をすでに確かめている
- ビューアとエディタを固定すると、そのビューアやエディタを入れていない環境では、item を指定しない `verify` を使えない
- コメントの行き先と自動のコミットは、CLI の細部として、子の epic で決める

## 棄却した代替案

### item を 1 本ずつ指定する verify だけを持つ

記録には、この案に固有の不採用の理由は無い。use_case が、item を指定せずに枝をたどって確認することを
求めているので採らなかった。

### ビューアとエディタを製品で固定する

記録には、この案に固有の不採用の理由は無い。CLI ができるまでの仮の実装は、ビューアとエディタを固定する。
製品では `mitodoke.yaml` で設定できるようにすると決めた。

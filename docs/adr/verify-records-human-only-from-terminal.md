---
id: "ADR-118fc416-3137-43b9-ab5b-49899dd4b2dc"
type: adr
name: "verify は、端末で人が確認を入力したときだけ確認の記録を書く"
description: "mitodoke verify は、端末で人が確認を入力したときだけ human:<id> と現在時刻を書き、端末の無い実行では拒む。"
section: commands
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q8）で確定"
justifies:
  - "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
references:
  - "ADR-b9a7b27b-57ea-41cc-9509-126bea9d6d3e"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-21T18:24:29+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T22:05:30+09:00"
---
# verify は、端末で人が確認を入力したときだけ確認の記録を書く

- ステータス: stable
- 日付: 2026-11-17
- 関連: [human: 以外の verified も受け付け、基準時刻には数えるが人の確認には数えない](non-human-verified-accepted-not-counted-as-human.md), GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q8）で確定

## 背景

この決定の時点で、コンセプト文書の §6 は、`verified` に人の確認を記録し、人が値を書いてコミットするとしていた。
§11 の 6 は、自動化が、人が確認したという印を知らないうちに付けてはならないとしている。
人の確認を記録する手段は、人が YAML を手で書くことしか無く、エージェントが書くことを機械で止める
仕組みも無かった。`verified` に人の確認を書く手段を決める必要があった。

## 決定

`mitodoke verify <item>` を用意する。端末で人が確認を入力したときだけ `human:<id>` と現在時刻を書き、
TTY の無い実行（CI やエージェント）では拒む。疑似端末を使えばこの確認を越えられるので、この確認は
人の確認の証明ではない。人の確認を最終的に示すのは、人がその変更をコミットしたという記録である。

書く内容と拒む条件は [verify は端末での人の入力があるときだけ人の確認を記録する](../requirements/human-verification-recording.md) が定める。
`<id>` の取り方は、この ADR では決めない。

## 根拠

- エージェントが実行するコマンドは TTY を持たないので、TTY の確認で、エージェントが人の確認を書くことを機械的に止められる。§11 の 6 の求めに沿う
- 疑似端末で越えられるので人の確認の証明にはならないが、人の確認を最終的に示すのは、人がその変更をコミットしたという記録である
- 人が YAML を手で書く方式のままでは記録の手間が減らないので、人が確認を書く手間を減らす手段が要る

## 棄却した代替案

### コマンドを作らず、人が YAML を手で書く

今と同じく人が `verified` を手で書く案。記録の手間が減らず、エージェントが書くことを機械で止める手段も
無いので採らなかった。

### TTY を確かめない verify を用意する

`mitodoke verify` を用意するが TTY は確かめず、エージェントも実行できるようにし、人かどうかは actor の
書式で見分ける案。エージェントが人の確認を書くことを止められず、§11 の 6 の求めに沿わないので
採らなかった。

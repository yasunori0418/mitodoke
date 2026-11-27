---
id: "RISK-7c88c702-81f4-4424-b82a-ff9f3e978a7a"
type: risk
name: "基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する"
description: "基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: freshness
status: stable
threatens:
  - "REQ-0827f299-fbdc-46ed-8a04-ca4378ad0c79"
  - "REQ-73e736ca-7c31-4c0a-9448-80fb29347f1d"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# 基準時刻、辿る relation、直接の辺、deprecated の扱いを誤り、再確認待ちを見逃すか余分に報告する

## リスク

[下流の item の基準時刻より上流の generated.at が新しければ、下流を再確認待ちとして報告する](../requirements/staleness-judgement.md)
が破れ、再確認待ちを見逃すか余分に報告する懸念である。失敗の向きは次の 4 つある。

- 基準時刻に、`generated.at` 以降の `verified[].at` か `human:` 以外の actor の `verified` を数えず、
  余分に報告する
- 辿る 7 つの relation の一部を辿らないか、`justifies` や peer の relation を辿る
- 直接の辺を越えて、上流の上流まで比べる
- `deprecated` の item を上流か下流として数える

[独自の relation は、再確認待ちを伝播させるかを設定で宣言する](../requirements/staleness-propagation-declared-for-custom-relations.md)
への辺は、伝播させると宣言した独自の relation を辿り、宣言していない独自の relation を辿らないことを
指す。設定が独自の relation の宣言を受け付けない懸念は
[独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る](custom-definitions-rejected-or-out-of-scope.md)
が持つ。

最も重い向きは、組み込みの 7 つの relation の一部を辿らずに再確認待ちを見逃す向きで、この risk は
この向きで採点する。見逃した下流は報告に出ないので、誤りは表に出ない。`deprecated` の上流を
数えて余分に報告する向きは、利用者が読めば誤りと分かる。`gap` の側で `deprecated` の item と辺を数え誤る
懸念は
[gap が deprecated の item や片方の端が deprecated の辺を数え、欠けを見逃すか余分に報告する](gap-miscounts-valid-items-and-edges.md)
が持ち、時刻を文字列として比べる懸念は
[時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う](timestamp-misread-or-compared-as-string.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。採点した向きでは、辿る 7 つの relation と
辿らない 4 つの relation が分かれ、張り元と張り先の型の組が relation ごとに違い、`fresh` と `check` が
同じ判定を使う。
見逃しやすさは低い。写した `dev/tests/sara-fresh.sh` は、7 つの relation ごとの下流、`justifies` と
`depends_on` を辿らないこと、`generated.at` の前後の `verified`、`deprecated` の上流と下流、UTC オフセットの
違う時刻を確かめている。採点していない独自の relation の宣言は確かめていない。

impact は medium とした。誤った再確認待ちの報告は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

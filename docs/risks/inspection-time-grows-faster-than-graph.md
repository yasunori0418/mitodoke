---
id: "RISK-b1f3ca41-8969-4f20-94b7-dcbe4a4b2dec"
type: risk
name: "git と設定のコマンドを文書ごとに呼ぶか、辺の突き合わせが item の数の 2 乗で伸び、大きなグラフで CI の検査が使えなくなる"
description: "git と設定のコマンドを文書ごとに呼ぶか、辺の突き合わせが item の数の 2 乗で伸び、大きなグラフで CI の検査が使えなくなる"
likelihood: low
impact: medium
level: low
quality_characteristic: performance_efficiency
section: inspection
status: stable
threatens:
  - "REQ-af47f52f-4ff5-4298-8746-6b5e8b76ce52"
  - "DSG-4e5433cd-56bb-4008-a16b-f42f236f19c4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:56:05+09:00"
---
# git と設定のコマンドを文書ごとに呼ぶか、辺の突き合わせが item の数の 2 乗で伸び、大きなグラフで CI の検査が使えなくなる

## リスク

検査の時間がドキュメントグラフの大きさより速く伸び、大きなグラフを持つ製品で CI の検査が実用に
ならなくなる懸念である。
[CI 連携は CLI と workflow の例で提供する](../requirements/ci-integration-form.md) は、pull request ごとに
`mitodoke check` と `mitodoke fresh --base <基準>` を実行する形を示すので、検査の時間がそのまま CI の
待ち時間になる。失敗の向きは次の 2 つある。

- git や設定のコマンドを文書ごとに呼び、プロセスの起動の時間が item の数に比例して積み上がる
- 辺の突き合わせを item の総当たりで書き、時間が item の数の 2 乗で伸びる

最も重い向きは、辺の突き合わせが 2 乗で伸びる向きで、この risk はこの向きで採点する。小さなグラフでは
差が出ないので、利用者のグラフが大きくなるまで表に出ない。写した shell script の `sara-gap` は 4 万
ファイルで 14.55 秒かかり、同じグラフで `sara check` は 0.26 秒だった。遅さの原因は shell での突き合わせの
書き方で、sara-core の読み込みではない。

[ドキュメントグラフの読み込みを 1 つの結果にまとめる](../design/unified-graph-loading.md) への辺は、
すべてのサブコマンドが 1 回の読み込みの結果から item を得る設計に固有の面を指す。この結果が辺を引ける
形を持たないと、サブコマンドごとに総当たりの突き合わせを書くことになる。サブコマンドごとに読み込む
設計へ差し替えれば、この面は読み込みの重複という別の懸念になる。

## 実現性

likelihood は low とした。変わりやすさは低い。懸念は実装の選び方を誤ったときだけ起き、要件の規則の
分岐には依らない。見逃しやすさは高い。写した契約テストは、どれも検査の時間を測っていない。
変わりやすさと見逃しやすさの片方だけが高いときは medium とする読み替えの規則に当てると medium になる。
それでも low としたのは、sara-core の読み込みが 4 万ファイルで 0.26 秒であることを実測で確かめていて、
読み込みの結果を引く実装を選べば、遅くなる経路が残らないためである。

impact は medium とした。遅い検査は CI の待ち時間を延ばすが、結果は誤らず、実装を直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

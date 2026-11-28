---
id: "RISK-9b097a3d-e946-4c81-b940-cca8816b33d2"
type: risk
name: "強さの設定が働かず、失敗にする指摘を報告として扱うか、読み込みの前提まで設定で緩む"
description: "強さの設定が働かず、失敗にする指摘を報告として扱うか、読み込みの前提まで設定で緩む"
likelihood: high
impact: medium
level: high
quality_characteristic: functional_suitability
section: inspection
status: stable
threatens:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# 強さの設定が働かず、失敗にする指摘を報告として扱うか、読み込みの前提まで設定で緩む

## リスク

検査の強さの設定が指摘に正しく当たらない懸念である。
[検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md)
は、3 つの分類の既定の強さと、設定でそれを変えられること、読み込みの前提を設定の対象にしないことを
求める。失敗の向きは次の 3 つある。

- 設定で失敗にした指摘を報告として扱い、`check` が exit code 0 で終わる。既定で失敗の構造の契約を、
  設定が無いのに報告にする向きもここに入る
- 設定で報告にした指摘を失敗として扱い、`check` が exit code 1 で終わる
- 読み飛ばされたファイルやモデルを読めないことまで設定で報告に緩み、`check` が通る

[サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md)
への辺は、`check` が 3 つの分類をまとめて実行し、指摘ごとに失敗か報告かを設定の強さで決めることを指す。
[check・gap・fresh の item は契約と文書の組を単位とする](../requirements/result-item-unit.md) への辺は、
単体の `gap` と `fresh` では該当した組をすべて失敗にし、`check` だけが強さの設定に従うという、
サブコマンドによる分かれ目を指す。

最も重い向きは、失敗にする指摘を報告として扱う向きで、この risk はこの向きで採点する。CI は exit code
で止めるので、報告に落ちた違反は CI を通り、誤りは表に出ない。強さに合わせて指摘のコードと item の
`status` を選ぶ懸念は
[指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う](finding-code-and-status-mismatch-strength.md)
が持ち、読み飛ばしの扱いそのものは
[読み飛ばされたファイルやモデルを読めないことを見逃し、欠けたグラフのまま検査や書き込みを続ける](partial-graph-treated-as-complete.md)
が持つ。

## 実現性

likelihood は high とした。変わりやすさは高い。強さは 3 つの分類と設定の組で決まり、`check` と単体の
`gap`・`fresh` で扱いが分かれ、読み込みの前提は設定から外す。見逃しやすさも高い。写した契約テストは
強さの設定を持たず、設定が強さを変えることも、前提が設定で緩まないことも確かめていない。

impact は medium とした。強さを取り違えた結果は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

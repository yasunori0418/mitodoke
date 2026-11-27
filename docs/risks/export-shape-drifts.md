---
id: "RISK-f1bfeaad-f950-4d64-a4b3-945c7f1ec4c1"
type: risk
name: "export の item の形が、sara 0.12 の items[] に OKF のキーを加えた形から外れる"
description: "export の item の形が、sara 0.12 の items[] に OKF のキーを加えた形から外れる"
likelihood: medium
impact: medium
level: medium
quality_characteristic: compatibility
section: result-handoff
status: stable
threatens:
  - "REQ-4ac9181f-5394-4617-b05e-be2387228008"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:11:40+09:00"
---
# export の item の形が、sara 0.12 の items[] に OKF のキーを加えた形から外れる

## リスク

`export` が出す item の形が、
[export は文書 1 件を item とし、sara 0.12 の items[] の形に OKF のキーを加えて出す](../requirements/export-shape.md)
の定める形から外れる懸念である。失敗の向きは次の 2 つある。

- 文書 1 件を item 1 つで表さない。1 件を複数の item に分けるか、item にしない文書がある
- item の `info` の下の形が sara 0.12 の `items[]` から写した形と食い違うか、OKF のキー `generated`・
  `verified`・`sources`・`stale_after` のどれかが欠ける

最も重い向きは、`info` の下の形が食い違うか OKF のキーが欠ける向きで、この risk はこの向きで採点する。
`export` の出力を読む外のツールは、キーが無ければ値が無いものとして扱うので、誤りは JSON の読み込みの
失敗として表に出ない。文書の数と item の数の食い違いは、件数を数えれば気づける。

sara-core の版を上げたときに新しい sara の形がそのまま出る懸念は
[sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる](sara-core-breaking-change-alters-results.md)
が持ち、エンベロープの側の形の食い違いは
[結果エンベロープの形がサブコマンドによって食い違う](envelope-shape-diverges-across-subcommands.md)
が持つ。

## 実現性

likelihood は medium とした。どちらの軸も、採点した形の食い違いの向きで見る。変わりやすさは低い。規則は
写した形に 4 つの OKF のキーを加えることだけで、分岐を持たず、`export` だけが使う。見逃しやすさは高い。
`export` に当たる契約テストは無い。写した `dev/tests/term-avoid.sh` は `sara check --format json` の
`.items` が配列であることだけを確かめ、item の形も OKF のキーも確かめていない。

impact は medium とした。形の食い違いで受け取る側のツールが誤った値で動くが、直した版で `export` を
やり直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

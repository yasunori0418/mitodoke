---
id: "RISK-aef109fb-1e12-4363-948f-c67492e957f5"
type: risk
name: "結果エンベロープの形がサブコマンドによって食い違う"
description: "結果エンベロープの形がサブコマンドによって食い違う"
likelihood: high
impact: medium
level: high
quality_characteristic: compatibility
section: foundation
status: stable
threatens:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
  - "DSG-b70a4bcf-fa63-4b19-a123-1076b32df625"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:15:31+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:04:12+09:00"
---
# 結果エンベロープの形がサブコマンドによって食い違う

## リスク

`--json` の結果エンベロープの形が、サブコマンドによって
[サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない](../requirements/json-outturn-envelope.md)
と [check・gap・fresh の item は契約と文書の組を単位とする](../requirements/result-item-unit.md) から外れる
懸念である。食い違う形は次のものを指す。

- `results[]` の要素が 1 つでない、または `subject.name` が `documents` でない
- `dryRun` の値が、ファイルを書くサブコマンド（false）、`index` と `model` の `--check`（true）、読むだけの
  サブコマンド（true）の区別と合わない
- 読むだけのサブコマンドが `changes[]` を出すか、ファイルを書くサブコマンドが `add` と `modify` を並べない
- 文書を表す item の `label` が文書の `name` でないか、文書の ID を持たない item の `key` と `label` が設定
  ファイルのあるディレクトリからの相対パスでない

どの向きも、エンベロープを読む外のツールが誤った結果を受け取る点で同じ重さである。outturn の仕様に適合
しないエンベロープでも JSON としては読めるので、受け取る側が形を確かめない限り誤りは表に出ない。
指摘のコードの接頭辞と item の `status` が強さと食い違う懸念は
[指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う](finding-code-and-status-mismatch-strength.md)
が持ち、outturn の仕様そのものが変わる懸念は
[draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる](outturn-spec-change-breaks-conformance.md)
が持つ。

[結果エンベロープを outturn のモジュールで組み立てる](../design/result-envelope-assembly.md) への辺は、
text 出力もエンベロープから作る設計に固有の面を指す。エンベロープの組み立ての誤りが text 出力にも及び、
サブコマンドごとに出力を組み立てる設計へ差し替えれば、この連鎖は消える。

## 実現性

likelihood は high とした。変わりやすさは高い。10 のサブコマンドが同じ形を共有し、ファイルを書くもの、
`--check`、読むだけのもので `dryRun` と `changes[]` の扱いが分かれる。見逃しやすさも高い。写した契約
テストは outturn のエンベロープを出さないので、この形をどれも確かめていない。

impact は medium とした。誤った形のエンベロープは出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

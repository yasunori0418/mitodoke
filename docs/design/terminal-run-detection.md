---
id: "DSG-492d1939-13ab-48b3-bfa1-cf3aded23b97"
type: design
name: "端末からの実行の判定を共通のモジュールの 1 か所に置く"
description: "stdin と stdout の両方が端末であることで端末からの実行を判定し、その判定を共通のモジュールに置いて verify と new で同じものを使う"
section: product-scope
status: stable
satisfies:
  - "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
  - "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:35:41+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:00:40+09:00"
---
# 端末からの実行の判定を共通のモジュールの 1 か所に置く

## 設計

「端末からの実行」は、stdin と stdout の両方が端末であることで判定する。判定は小さな共通のモジュールの
1 か所に置き、`verify` と `new` は同じ判定を使う。どちらのサブコマンドも、端末かどうかを自分で調べない。

判定の結果は、2 つのサブコマンドで次のように使う。

| サブコマンド | 端末からの実行のとき | 端末からの実行でないとき |
|---|---|---|
| `verify` | 人が確認を入力したときだけ、`human:<id>` の要素を `verified` に書く | 確認の記録を書くことを拒む |
| `new`（`generated.by` を環境変数 `MITODOKE_GENERATED_BY` からも引数 `--by` からも取れないとき） | 設定のコマンドの出力から `human:<id>` を作り、`generated.by` に書く | 起票を拒む |

判定を外す環境変数は、製品に持たない。エージェントや CI のような実行が、環境変数を設定して人の確認や人の
識別子を書けないようにするためである。

## 出典

根拠の決定は次の ADR が持つ。

- [端末からの実行は stdin と stdout の両方が端末であることで判定する](../adr/terminal-run-judged-by-stdin-and-stdout.md)
- [CLI を 1 つの crate にし、役割ごとのモジュールに分ける](../adr/single-crate-split-into-role-modules.md)

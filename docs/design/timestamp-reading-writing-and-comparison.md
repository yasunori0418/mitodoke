---
id: "DSG-e5c2e54c-e8e3-429b-b640-9f30f74c223f"
type: design
name: "時刻の読み書きと比較を共通のモジュールに置く"
description: "generated.at と verified[].at の時刻を受け付ける書式、書く書式、時刻としての比べ方を共通のモジュールの 1 か所に置き、検査と new と verify と fresh が同じものを使う"
section: product-scope
status: stable
satisfies:
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
  - "REQ-0827f299-fbdc-46ed-8a04-ca4378ad0c79"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:35:15+09:00"
---
# 時刻の読み書きと比較を共通のモジュールに置く

## 設計

`generated.at` と `verified[].at` の時刻の読み書きと比較は、小さな共通のモジュールの 1 か所に置く。
OKF のキーの検査、`new` と `verify` の書き込み、`fresh` と `check` の鮮度の比較は、どれもこのモジュールを
使い、時刻を自分で読み書きしない。

### 受け付ける書式

- UTC オフセット付きの ISO 8601 を受け付ける。小数の秒と `Z` も受け付ける
- 現在時刻より先の `generated.at` と `verified[].at` は、OKF のキーの値の違反にする

### 書く書式

`new` が書く `generated.at` と、`verify` が書く `verified[].at` は、実行した環境のローカルの UTC
オフセットを付けた、秒までの形にする（例 `2026-11-23T13:45:23+09:00`）。2 つのサブコマンドは、この
モジュールの同じ書き方を使うので、書く形が食い違わない。

### 比べ方

- 時刻は、文字列ではなく時刻として読んで比べる。オフセットの違う時刻を並べても、順序を誤らない
- `generated.at` の表記だけを書き換えて同じ時刻を指しているときは、変わっていないとみなす

## 出典

根拠の決定は次の ADR が持つ。

- [時刻は UTC オフセット付きで受け付けてローカルのオフセットで書き、時刻として比べる](../adr/timestamps-accepted-written-and-compared-as-instants.md)
- [CLI を 1 つの crate にし、役割ごとのモジュールに分ける](../adr/single-crate-split-into-role-modules.md)

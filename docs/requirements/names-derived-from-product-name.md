---
id: "REQ-d7a8bbab-8ca2-4d3e-b20b-0f845c370283"
type: requirement
name: "設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める"
description: "コマンド・設定ファイル・環境変数・エラーと警告のコード・crate と flake の出力の名前は、製品名 mitodoke から決める"
specification: |
  Every name of the product that carries the product name SHALL carry `mitodoke`. The name
  of the command, the name of the configuration file, the name of the crate and the names
  of the flake outputs that the product defines for itself SHALL use the lowercase form
  `mitodoke`. The names of the product's environment variables and the product-specific
  prefixes of its error and warning codes SHALL use the uppercase form `MITODOKE`.
specification_ja: |
  製品の名前のうち製品名を含むものは、`mitodoke` を含まなければならない。コマンドの名前、
  設定ファイルの名前、crate の名前、製品が自身のために定める flake の出力の名前は、小文字の
  `mitodoke` を使わなければならない。製品の環境変数の名前と、エラーと警告のコードの製品に
  固有の接頭辞は、大文字の `MITODOKE` を使わなければならない。
section: product-scope
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:45:54+09:00"
---
# 設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める

## 仕様

製品の名前のうち製品名を含むものは、製品名 `mitodoke` から決める。

- 小文字の `mitodoke` を使う名前: コマンド（`mitodoke <サブコマンド>`）、設定ファイル
  （`mitodoke.yaml`）、crate、製品が自身のために定める flake の出力
- 大文字の `MITODOKE` を使う名前: 環境変数（`MITODOKE_GENERATED_BY` など）、エラーと警告の
  コードの接頭辞（`E_MITODOKE_<契約名>`・`W_MITODOKE_<契約名>`）

それぞれの名前が何を表し、どう使われるかは、それぞれの要件が定める。この要件が定めるのは、
名前を製品名から決めることだけである。

## 出典

根拠の決定は次の ADR が持つ。

- [製品名を mitodoke にする](../adr/product-named-mitodoke.md)

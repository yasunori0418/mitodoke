---
id: "REQ-d7a8bbab-8ca2-4d3e-b20b-0f845c370283"
type: requirement
name: "設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める"
description: "コマンド・設定ファイル・環境変数・エラーと警告のコード・crate と flake の出力の名前は、製品名 mitodoke から決める"
specification: |
  The names that the product exposes to its users SHALL be derived from the product name
  `mitodoke`. The command name, the configuration file name, the crate name and the names
  of the flake outputs SHALL use the lowercase form `mitodoke`. The names of environment
  variables and the product-specific prefixes of error and warning codes SHALL use the
  uppercase form `MITODOKE`. No such name SHALL use any other product name.
specification_ja: |
  製品が利用者に見せる名前は、製品名 `mitodoke` から決めなければならない。コマンド・設定
  ファイル・crate・flake の出力の名前は、小文字の `mitodoke` を使わなければならない。環境
  変数の名前と、エラーと警告のコードの製品に固有の接頭辞は、大文字の `MITODOKE` を使わなければ
  ならない。これらの名前に、ほかの製品名を使ってはならない。
section: product-scope
status: stable
derives_from:
  - "UC-a81ec7f7-0fb1-4ada-ae7c-0a20cdc0b074"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:35:15+09:00"
---
# 設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める

## 仕様

利用者が打つ・書く・読む名前は、製品名 `mitodoke` から決める。

- 小文字の `mitodoke` を使う名前: コマンド（`mitodoke <サブコマンド>`）、設定ファイル
  （`mitodoke.yaml`）、crate、flake の出力
- 大文字の `MITODOKE` を使う名前: 環境変数（`MITODOKE_GENERATED_BY` など）、エラーと警告の
  コードの接頭辞（`E_MITODOKE_<契約名>`・`W_MITODOKE_<契約名>`）

それぞれの名前が何を表し、どう使われるかは、それぞれの要件が定める。この要件が定めるのは、
名前を製品名から決めることだけである。

## 出典

根拠の決定は次の ADR が持つ。

- [製品名を mitodoke にする](../adr/product-named-mitodoke.md)

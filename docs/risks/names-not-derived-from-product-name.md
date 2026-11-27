---
id: "RISK-698d990d-942d-4605-b786-77f8c565f08b"
type: risk
name: "設定ファイル、環境変数、コードの接頭辞の名前が製品名から外れる"
description: "設定ファイル、環境変数、コードの接頭辞の名前が製品名から外れる"
likelihood: low
impact: medium
level: low
quality_characteristic: functional_suitability
section: distribution
status: stable
threatens:
  - "REQ-d7a8bbab-8ca2-4d3e-b20b-0f845c370283"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:13:17+09:00"
---
# 設定ファイル、環境変数、コードの接頭辞の名前が製品名から外れる

## リスク

[設定ファイル・環境変数・コードの接頭辞の名前は製品名から決める](../requirements/names-derived-from-product-name.md)
が破れる懸念である。失敗の向きは次の 3 つある。

- 小文字の `mitodoke` を使う名前（コマンド、設定ファイル、crate、flake の出力）が製品名から外れる
- 大文字の `MITODOKE` を使う環境変数の名前が製品名から外れる
- 大文字の `MITODOKE` を使うエラーと警告のコードの接頭辞が製品名から外れる

最も重い向きは、環境変数の名前が外れる向きで、この risk はこの向きで採点する。利用者が
`MITODOKE_GENERATED_BY` に入れた値を `new` が読まないと、端末からの実行では設定のコマンドから作った
`human:` の値を黙って `generated.by` に書く。コマンドと設定ファイルの名前の誤りは、実行した時点で
見つからないので気づける。コードの接頭辞の誤りは、出力のどの指摘のコードにも現れるので、出力を読めば
気づける。コードの接頭辞の `E_` と `W_` が強さと食い違う懸念は
[指摘のコードの接頭辞、item の status、置き場所が、その実行で働く強さと食い違う](finding-code-and-status-mismatch-strength.md)
が持つ。

## 実現性

likelihood は low とした。変わりやすさは低い。採点した向きの規則は、環境変数に大文字の `MITODOKE` を
使うことだけで、分岐を持たない。見逃しやすさも低い。写した `dev/tests/sara-new.sh` は、環境変数を
名前で渡し、その値が `generated.by` に書かれることを確かめている。

impact は medium とした。誤った出どころの記録は出荷物の誤動作だが、名前を直した版で起票し直せば回復
できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

---
id: "RISK-5b8d2eda-2f0d-4fd1-838f-4a6a93900e47"
type: risk
name: "設定ファイルを上のディレクトリから拾うか、読んだ設定と暗黙の入力を info に誤って記録する"
description: "設定ファイルを上のディレクトリから拾うか、読んだ設定と暗黙の入力を info に誤って記録する"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: foundation
status: stable
threatens:
  - "REQ-ecc41a24-b465-4ab9-ba1b-e56dc5f8a17c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:02:41+09:00"
---
# 設定ファイルを上のディレクトリから拾うか、読んだ設定と暗黙の入力を info に誤って記録する

## リスク

[設定ファイルは作業ディレクトリから読み、作業ディレクトリを workingDirectory に、設定ファイルのパスと暗黙の入力を info に記録する](../requirements/config-discovery-and-record.md)
が破れる懸念である。失敗の向きは次の 2 つある。

- `--config` を省いたときに、作業ディレクトリに設定ファイルが無いと上のディレクトリを探し、別の製品の
  設定で検査や生成をする
- エンベロープの `info` に、読んだ設定ファイルの絶対パスや、環境変数 `MITODOKE_GENERATED_BY` と設定の
  コマンドから得た値を記録しないか、`--by` が優先されて使わなかった環境変数の値を記録する。作業ディレクトリを
  `workingDirectory` ではなく `info` に書くことも含む

最も重い向きは、別の設定で検査や生成をする向きで、この risk はこの向きで採点する。上のディレクトリの設定
でも検査は形のうえでは成り立つので、結果は誤りとしては目に見えない。`info` の記録の誤りも、エンベロープを
読む側が出どころを確かめるまで表に出ない。

## 実現性

likelihood は medium とした。変わりやすさは低い。設定ファイルの選び方は `--config` の有無の 2 通りで、
`info` に載せる値も `--by`・環境変数・設定のコマンドの 3 つの出どころに限られ、どのサブコマンドも同じ
規則を使う。見逃しやすさは高い。写した契約テストは作業ディレクトリの `sara.toml` を読む前提で動き、上の
ディレクトリを探さないことも、`info` の中身も確かめていない。

impact は medium とした。誤った設定での検査や生成は出荷物の誤動作だが、正しい設定を指して再実行すれば
回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

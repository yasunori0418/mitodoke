---
id: "DSG-e6af0d04-58c4-4c32-83d9-7b0d02fb0dab"
type: design
name: "受け入れテストは、ビルドしたバイナリを fixture のリポジトリに対して実行する"
description: "テスト計画 4 本が定めた受け入れテストの実行の仕方をまとめ、それを実行する仕組みを draft で表す"
section: product-scope
status: draft
satisfies:
  - "TP-cf0c38d2-8929-4a69-adef-8d2dc63115df"
  - "TP-2d0beccd-8660-4804-8637-4c4e83736efe"
  - "TP-cefb0111-5c50-4f89-8955-b63b3c5904c8"
  - "TP-8c2f612e-bc08-438f-a6cd-9b73028084b7"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:27:31+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:07:32+09:00"
---
# 受け入れテストは、ビルドしたバイナリを fixture のリポジトリに対して実行する

## 設計

受け入れテストを実行する仕組みは、次のテスト計画がすでに定めたことを満たす。この item は新しい設計の決定をせず、
定めたことを 1 か所にまとめる。

| テスト計画 | 仕組みが満たすこと |
|---|---|
| [mitodoke 自身のテストは 7 つの区分に分け、単体のテストと受け入れテストの 2 つのレベルで確かめる](../test-plan/test-levels-and-scope.md) | ビルドしたバイナリを fixture のリポジトリに対して実行する。fixture は自分の `mitodoke.yaml` を持ち、実物の `docs/model.yaml` を重ねない。`verify` と、`new` が設定のコマンドから人の識別子を取る場合は、疑似端末で流す |
| [CLI の受け入れは、写した契約テストで確かめる](../test-plan/acceptance-by-copied-contract-tests.md) | 写した契約テストの期待で、`result.info` の下の JSON のキー、exit code、起票で出す `id:` と `file:` の 2 行を確かめる。偽の sara に差し替える節は外す |
| [outturn への適合は受け入れテストで --json の出力のサンプルを schema に照らして確かめる](../test-plan/outturn-conformance-by-schema-check.md) | `--json` の出力のサンプルを、outturn の flake の `lib.mkSchemaCheck` で schema に照らす |
| [sara の挙動に依る検査は、mitodoke の結果を期待にして受け入れテストで確かめる](../test-plan/sara-dependent-inspections-checked-by-mitodoke-results.md) | sara の挙動を確かめた実験の入力を fixture にし、mitodoke の結果を期待にする |

## 今の状態

仕組みはまだ無い。mitodoke の CLI のコードが無く、受け入れテストを実行するものも無い。
#6 の子の epic が仕組みを作り、そのときに詳細を書いて `status` を `stable` にする。

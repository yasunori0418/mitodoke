---
id: "TP-cf0c38d2-8929-4a69-adef-8d2dc63115df"
type: test_plan
name: "CLI の受け入れは、写した契約テストで確かめる"
description: "mitodoke の CLI の受け入れは、写した契約テストで、result.info の下の JSON のキー・exit code・起票の id: と file: の 2 行を写した fixture と同じ期待で確かめる。"
specification: |
  The test process SHALL use the copied contract tests as the acceptance tests of the mitodoke
  CLI, checking its subcommands against the same expectations as the copied fixtures. The
  acceptance tests SHALL check the JSON keys under result.info of the outturn envelope, the exit
  codes (0 for no findings, 1 for findings, 2 for input or environment errors), and the two lines
  id: and file: printed on creating an item, and SHALL check a finding that yields exit code 1 as
  an item whose status is failed. The acceptance tests SHALL NOT require the headings and the
  line format of the text output to match the copied fixtures. The sections of the copied tests
  that replace sara with a fake one SHALL be excluded from the acceptance tests. Whether check
  fails or reports according to the strength setting is treated separately, and the acceptance
  tests SHALL check that a single reporting subcommand returns exit code 1 when it has findings.
specification_ja: |
  テストプロセスは、写した契約テストを mitodoke の CLI の受け入れテストに使い、サブコマンドを写した
  fixture と同じ期待で確かめなければならない。受け入れテストは、outturn のエンベロープの
  result.info の下の JSON のキー、exit code（0 は該当なし、1 は該当あり、2 は入力や環境の誤り）、
  起票で出す id: と file: の 2 行を確かめなければならず、exit code 1 になる該当を status が failed
  の item として確かめなければならない。受け入れテストは、text 出力の見出しと行の形式を、写した
  fixture と揃うことを求めてはならない。写した契約テストのうち、偽の sara に差し替える節は、受け入れ
  テストから外さなければならない。check が強さの設定で失敗か報告かを決めることは別に扱い、
  受け入れテストは、単体の報告のサブコマンドが該当ありで exit code 1 を返すことを確かめなければ
  ならない。
status: stable
derives_from:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T17:06:53+09:00"
---
# CLI の受け入れは、写した契約テストで確かめる

## 仕様

mitodoke の CLI の受け入れテストには、写した契約テストを使う。CLI のサブコマンドを、写した
fixture と同じ期待で確かめる。

揃えるのは次の 3 つで、text 出力の見出しと行の形式は揃えない。

- outturn のエンベロープの `result.info` の下の JSON のキー
- exit code（0 は該当なし、1 は該当あり、2 は入力や環境の誤り）。exit code 1 になる該当は、
  `status` が `failed` の item として確かめる
- 起票で出す `id:` と `file:` の 2 行

写した契約テストのうち、偽の sara に差し替えて確かめる節（JSON の形の異常で exit code 2 になる
こと、`sara init` の exit code 3 がそのまま返ること）は外す。

単体の報告のサブコマンドが該当ありで exit code 1 を返すことと、`check` が強さの設定に従って
失敗か報告かを決めることは別に扱い、受け入れテストは前者を確かめる。

## 出典

根拠の決定は次の ADR が持つ。

- [写した契約テストを CLI の受け入れテストにする](../adr/contract-tests-as-cli-acceptance-tests.md)

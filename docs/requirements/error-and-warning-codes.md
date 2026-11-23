---
id: "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
type: requirement
name: "契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す"
description: "契約の違反は E_MITODOKE_<契約名>、報告は W_MITODOKE_<契約名> のコードで表し、入力や環境の誤りには outturn の共通コードを使う。"
specification: |
  mitodoke SHALL code a finding against a contract as E_MITODOKE_<contract name> when the
  strength applied to it in the run is failure, and as W_MITODOKE_<contract name> when the
  strength applied to it is report. The same finding SHALL carry the same contract name under
  either strength. The strength setting SHALL switch only the prefix. For an input or
  environment error (exit code 2), mitodoke SHALL use the common code of outturn whose meaning
  corresponds to the error. mitodoke SHALL NOT use E_PRECONDITION for a violation found by
  check.
specification_ja: |
  mitodoke は、契約に対する指摘を、その実行で指摘に働く強さが失敗のときは E_MITODOKE_<契約名>
  で、報告のときは W_MITODOKE_<契約名> で表さなければならない。同じ指摘は、どちらの強さでも
  同じ契約名を持たなければならず、強さの設定で切り替わるのは接頭辞だけでなければならない。入力や環境の誤り（exit code 2）
  には、mitodoke は、outturn が定める共通コードのうち、その誤りの意味に当たるものを使わなければ
  ならない。mitodoke は、
  check が見つけた違反に E_PRECONDITION を使ってはならない。
section: json-output
status: stable
derives_from:
  - "UC-9fe6f27f-f51e-4532-838b-e84a57fa7eac"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:00:49+09:00"
---
# 契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す

## 仕様

契約の違反と報告は、ツール別のコードで表す。その実行で働く強さが失敗の指摘は
`E_MITODOKE_<契約名>`、報告の指摘は `W_MITODOKE_<契約名>` になる。同じ指摘は契約名を共通にし、
強さの設定で接頭辞だけが切り替わる。

入力や環境の誤り（exit code 2）には、outturn が定める共通コードのうち、その誤りの意味に当たるものを使う。
`check` の違反にも、`E_PRECONDITION` は使わない。

## 出典

根拠の決定は次の ADR が持つ。

- [契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える](../adr/tool-specific-error-and-warning-codes.md)

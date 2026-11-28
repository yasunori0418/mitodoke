---
id: "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
type: requirement
name: "契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す"
description: "契約の違反は E_MITODOKE_<契約名>、報告は W_MITODOKE_<契約名> のコードで表し、入力や環境の誤りには outturn の共通コードを使う。"
specification: |
  mitodoke SHALL code a finding against a contract as E_MITODOKE_<contract name> when the
  strength applied to it in the run is failure, and as W_MITODOKE_<contract name> when the
  strength applied to it is report. The strength applied to a finding in a run SHALL be failure
  when the finding makes the exit code of the run non-zero, and report otherwise. A finding at
  failure strength SHALL be the error of an item whose status is failed, and a finding at report
  strength SHALL be a warning of an item whose status is success; a pair of a contract and a
  document that has only findings at report strength SHALL also be an item. The information
  sections of gap and the reach ratios SHALL NOT be items and SHALL be placed in `result.info`.
  The same finding SHALL carry the same contract name under
  either strength. The strength setting SHALL switch only the prefix. For an input or
  environment error (exit code 2), mitodoke SHALL use the common code of outturn whose meaning
  corresponds to the error. mitodoke SHALL NOT use E_PRECONDITION for a violation found by
  check.
specification_ja: |
  mitodoke は、契約に対する指摘を、その実行で指摘に働く強さが失敗のときは E_MITODOKE_<契約名>
  で、報告のときは W_MITODOKE_<契約名> で表さなければならない。その実行で指摘に働く強さは、
  その指摘がその実行の exit code を 0 でなくするなら失敗、しないなら報告でなければならない。失敗の
  指摘は status が failed の item の error で、報告の指摘は status が success の item の warnings で
  表さなければならず、報告の指摘だけを持つ契約と文書の組も item にしなければならない。gap の情報の
  節と到達率は、item にしてはならず、`result.info` に置かなければならない。同じ指摘は、どちらの強さでも
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
  at: "2026-11-23T19:05:08+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:02:24+09:00"
---
# 契約の違反と報告は E_MITODOKE_ と W_MITODOKE_ のコードで表す

## 仕様

契約の違反と報告は、ツール別のコードで表す。その実行で働く強さが失敗の指摘は
`E_MITODOKE_<契約名>`、報告の指摘は `W_MITODOKE_<契約名>` になる。同じ指摘は契約名を共通にし、
強さの設定で接頭辞だけが切り替わる。

その実行で指摘に働く強さは、その指摘がその実行の exit code を 0 でなくするかどうかで決まる。0 でなく
するなら失敗、しないなら報告である。失敗の指摘は `status` が `failed` の item の `error` に、報告の指摘は
`status` が `success` の item の `warnings` に置く。報告の指摘だけを持つ契約と文書の組も item にする。
`gap` の情報の節と到達率は、item にせず、`result.info` に置く。

入力や環境の誤り（exit code 2）には、outturn が定める共通コードのうち、その誤りの意味に当たるものを使う。
`check` の違反にも、`E_PRECONDITION` は使わない。

## 出典

根拠の決定は次の ADR が持つ。

- [契約の違反と報告をツール別のコードで表し、強さで接頭辞だけを切り替える](../adr/tool-specific-error-and-warning-codes.md)
- [報告の指摘は success の item の警告で表し、働く強さは exit code で決める](../adr/report-findings-as-success-items-with-warnings.md)

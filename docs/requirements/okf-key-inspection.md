---
id: "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
type: requirement
name: "OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する"
description: "OKF のキーをどの型の item でも受け付け、その形と値が OKF v0.2 の定義に従っているかを構造の契約として検査する。"
specification: |
  The OKF keys `generated`, `verified`, `sources` and `stale_after` SHALL be accepted on an
  item of any type. Whether the shape and the values of these keys follow the OKF v0.2
  definitions SHALL be inspected as a structural contract.
specification_ja: |
  OKF のキー `generated`・`verified`・`sources`・`stale_after` は、どの型の item でも
  受け付けなければならない。これらのキーの形と値が OKF v0.2 の定義に従っているかは、
  構造の契約として検査しなければならない。
section: inspection
status: stable
derives_from:
  - "UC-630b51c7-5880-4cbb-b2b4-b05422061b0c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T11:01:27+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-23T13:42:30+09:00"
---
# OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する

## 仕様

OKF のキー（`generated`・`verified`・`sources`・`stale_after`）は、型によって受け付けを分けず、
どの型の item でも受け付ける。受け付けたキーは、形と値が OKF v0.2 の定義に従っているかを
構造の契約として検査する。

## 出典

根拠の決定は次の ADR が持つ。

- [OKF のキーは型を問わず受け付け、OKF v0.2 の定義に従うかを検査する](../adr/okf-keys-accepted-on-all-types.md)

OKF v0.2 の仕様は [GoogleCloudPlatform/open-knowledge-format の SPEC.md](https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/main/SPEC.md) にある。検査に使う節は次のとおりである。

- actor: §7
- `generated.at` と `verified`: §5.2
- `status`: §5.4
- `stale_after`: §5.5
- `sources`: §5.1
- 時刻（UTC オフセット付きの ISO 8601）: §5

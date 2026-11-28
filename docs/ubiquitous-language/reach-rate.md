---
id: "UBQ-7993c448-999a-48aa-8acb-562e6ad35980"
type: ubiquitous_term
name: "reach rate"
description: "ある型の item のうち、下流の連鎖が末端までつながっているものの割合。"
name_ja: "到達率"
avoid:
  - "カバー率"
section: inspection
status: stable
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-20T09:56:35+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:19:08+09:00"
---
# reach rate

## Definition

For the items of one type, the share whose chain of downstream items reaches through to
its end: for a requirement, a test case covering a test condition that reduces its risk;
for a test plan, a test case that follows it; for a quality, an infrastructure that
upholds it. An item can have a direct downstream item and still not be reached, so the
reach rate shows how far verification extends, not only whether the next link exists.

## Avoid

- カバー率: suggests the share of code that tests execute, a different measure. Write 到達率.

## 定義

ある型の item のうち、下流の連鎖が末端までつながっているものの割合。要件ならリスクを減らす
テスト条件をテストケースがカバーするところまで、テスト計画ならそれに従うテストケースまで、
品質ならそれを支える基盤までを末端とする。直下の下流を持っていても末端に届かない item は
あるので、到達率は次のつながりの有無ではなく、検証がどこまで届いているかを表す。

## 避ける表現

- カバー率: テストが実行したコードの割合という別の指標と紛れる語。到達率と書く。

---
id: "ADR-518a3910-4e6e-4e41-9ece-f6f4ea7b1700"
type: adr
name: "solution に stale_after を必須にし、期限までの間隔を 90 日以内にする"
description: "solution に stale_after を必須にし、期限切れと、人の確認の時刻から 90 日より先の期限を報告して、人の確認と書き換えの両方で期限を延ばす。"
section: verification
status: stable
sources:
  - id: "issue-80"
    resource: "https://github.com/yasunori0418/mitodoke/issues/80"
    title: "cli-upstream: 0 テストプロセスとホリスティックテスティングに、モデルと概念文書を適合させる"
origin: "issue #80 の grilling（2026-11-22）で確定"
justifies:
  - "QA-611977bd-3d11-4695-9fb2-a9f7211fcfbd"
  - "REQ-f27d4510-f215-403e-beda-b39fa824e368"
references:
  - "ADR-996af7b5-ed7c-4bb6-826f-0de50052f53e"
  - "ADR-05ab6fb0-899b-46e7-a853-82ed1b6857ff"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-22T17:23:48+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:55:51+09:00"
---
# solution に stale_after を必須にし、期限までの間隔を 90 日以内にする

- ステータス: stable
- 日付: 2026-11-22
- 関連: [item に生成者・確認の記録・期限のフィールドを持たせる](generated-verified-stale-after-fields.md), [solution と use_case は、確認の問いに人が答える妥当性確認でカバーする](upper-layers-validated-by-review-questions.md), GitHub Issue #80, `docs/model.yaml`, `dev/scripts/sara-new.sh`
- 起点: issue #80 の grilling（2026-11-22）で確定

## 背景

[再確認待ち](../ubiquitous-language/stale.md)は上流の item の変更から生じる。`solution` は上流を持たない
根なので、再確認待ちにならない。`solution` は製品の方向性を表し、確かめる手段は確認の問いに人が
答える[妥当性確認](../ubiquitous-language/validation.md)だけである。上流の変更が無くても、方向性が
今も妥当かは時間が経てば読み直す必要がある。

item には期限の `stale_after` を持たせられるが、これまでは期限のある事実を含む item に書き手が付ける
任意のフィールドだった。

## 決定

- `solution` は `stale_after` を必須にする。必須は `docs/model.yaml` で表し、`sara check` が確かめる。
  ほかの型では任意のまま残す。値の形は既存の決定のまま、UTC オフセット付きの ISO 8601 とする
- `stale_after` が現在時刻より前の有効な item（`status` が `deprecated` でないもの。`draft` を含む）を、[期限切れ](../ubiquitous-language/expired.md)として
  報告する。期限切れは、人が `stale_after` を先の時刻に書き換えたときだけ解ける
- `solution` の間隔は 90 日とする。`stale_after` が「起点 + 90 日」より先なら報告する。起点は
  `generated.at` 以降の最新の `human:` の `verified` の時刻で、無ければ `generated.at` とする
- 型と日数の組は `dev/tests/stale-after-intervals.tsv`（型と日数の 2 列）に書き、行の無い型は間隔を
  検査しない。CLI の設定ファイルができたら移す
- 期限を延ばすには、人の確認の記録と `stale_after` の書き換えの両方が要る
- `sara-new` は `solution` の起票で `--stale-after` が無ければ拒否する
- mitodoke の `solution` の最初の `stale_after` は、`generated.at`（2026-11-20）から 90 日後の 2027-02-18 とする

## 根拠

上流を持たない `solution` には、上流の変更の代わりに、時間の経過で読み直しを促す仕組みが要る。
必須を `docs/model.yaml` で表せば、既存の構造の検査が欠けを見つける。

間隔に上限が無ければ、遠い期限を書いて読み直しを先送りできる。起点を人の確認の時刻にすると、
確認を記録せずに期限だけを延ばした item は間隔の超過に挙がる。期限切れを書き換えでしか解かない
のは、次の期限を記録に残すためである。

`sara init` は必須の `stale_after` を省くと `TBD` を書く。起票の時点で拒否すれば、期限の無い
`solution` がグラフに入らない。

## 棄却した代替案

### stale_after を任意のまま、期限のある事実にだけ付ける

`solution` は上流を持たないので、読み直しの契機がどこにも無くなる。

### 期限切れを verified の追加だけで解く

次の期限が記録に残らず、同じ item がすぐにまた期限を過ぎる。

### 間隔を検査しない

遠い期限を書けば、読み直しをいくらでも先送りできる。

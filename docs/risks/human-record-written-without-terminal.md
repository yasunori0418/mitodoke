---
id: "RISK-42312f8a-458e-4bb8-ab5d-d6518485830f"
type: risk
name: "端末からの実行でないのに、人の確認や human: の generated.by を書く"
description: "端末からの実行でないのに、人の確認や human: の generated.by を書く"
likelihood: medium
impact: high
level: high
quality_characteristic: security
section: foundation
status: stable
threatens:
  - "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
  - "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
  - "DSG-492d1939-13ab-48b3-bfa1-cf3aded23b97"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:02:41+09:00"
---
# 端末からの実行でないのに、人の確認や human: の generated.by を書く

## リスク

エージェントや CI のような端末からでない実行が、人の確認や人の識別子を書く懸念である。失敗の向きは次の
2 つある。

- `verify` が、端末からの実行でないのに `human:<id>` の要素を `verified` に書く。
  [verify は端末での人の入力があるときだけ人の確認を記録する](../requirements/human-verification-recording.md)
  が破れる
- `new` が、`generated.by` を環境変数 `MITODOKE_GENERATED_BY` からも引数 `--by` からも取れず端末からの
  実行でもないのに、設定のコマンドの出力から `human:<id>` を作って書く。
  [generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする](../requirements/generated-by-source.md)
  が破れる

最も重い向きは、人の確認を偽って書く向きで、この risk はこの向きで採点する。書かれた `human:` の要素は
本物の人の確認と見分けが付かないので、誤りは表に出ない。具体的な経路の 1 つは、写した
`dev/scripts/sara-verify.sh` が持つ、端末の判定を外す環境変数 `SARA_VERIFY_TTY` である。要件は製品に
この種の環境変数を禁じているので、移植で持ち込めば判定を外す経路になる。

[端末からの実行の判定を共通のモジュールの 1 か所に置く](../design/terminal-run-detection.md) への辺は、
判定を `new` と `verify` で共有する設計に固有の面を指す。判定の誤りは 2 つのサブコマンドに一度に及び、
サブコマンドごとに判定する設計へ差し替えれば、この面は消える。

## 実現性

likelihood は medium とした。変わりやすさは低い。判定は stdin と stdout の両方が端末かという 1 つの条件で、
1 か所に置く。見逃しやすさは高い。写した `dev/scripts/sara-new.sh` は端末からの実行で人の識別子を作る
分岐を持たないので、その契約テストはこの分岐を確かめていない。`dev/tests/sara-verify.sh` は端末でない
実行を拒むことを確かめているが、端末の場合を `SARA_VERIFY_TTY` で作るので、そのままでは製品に写せない。

impact は high とした。偽の人の確認は、後から見つけても本物の確認と区別して取り除けず、再実行では
回復できない。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

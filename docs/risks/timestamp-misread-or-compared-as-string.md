---
id: "RISK-e02521f8-3dba-4ecc-b7d2-c87e485ed271"
type: risk
name: "時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う"
description: "時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: foundation
status: stable
threatens:
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
  - "REQ-0827f299-fbdc-46ed-8a04-ca4378ad0c79"
  - "DSG-e5c2e54c-e8e3-429b-b640-9f30f74c223f"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:15:31+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:52:53+09:00"
---
# 時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う

## リスク

`generated.at` と `verified[].at` の時刻を誤って扱う懸念である。失敗の向きは次の 3 つある。

- 時刻を文字列として比べ、UTC オフセットの違う時刻の順序を誤る。
  [下流の item の基準時刻より上流の generated.at が新しければ、下流を再確認待ちとして報告する](../requirements/staleness-judgement.md)
  の判定が狂い、再確認待ちを見逃すか余分に報告する
- [OKF のキーは型を問わず受け付け、OKF v0.2 の形と値を検査する](../requirements/okf-key-inspection.md)
  が受け付ける書式（小数の秒と `Z`）を違反にするか、現在時刻より先の時刻を通す
- `new` と `verify` が、ローカルの UTC オフセットを付けた秒までの形と違う形で書く

最も重い向きは、再確認待ちを見逃す向きで、この risk はこの向きで採点する。文字列の比較は同じオフセットの
時刻どうしなら正しく働くので、オフセットの混ざったリポジトリで初めて誤りが表に出る。

[時刻の読み書きと比較を共通のモジュールに置く](../design/timestamp-reading-writing-and-comparison.md)
への辺は、時刻の扱いを 1 つのモジュールに集める設計に固有の面を指す。そのモジュールの誤りは検査と書き込みの
すべてに一度に及び、サブコマンドごとに時刻を扱う設計へ差し替えれば、この面は消える。

## 実現性

likelihood は medium とした。変わりやすさは高い。受け付ける書式、未来の時刻の扱い、表記だけの書き換えの
扱いと分岐が多く、`check`・`new`・`verify`・`fresh` が同じ規則を共有する。見逃しやすさは低い。写した契約
テストのうち `dev/tests/okf-frontmatter.sh` は `Z` の受け付けと未来の時刻を、
`dev/tests/sara-fresh.sh` はオフセットの違う時刻の比較を確かめている。

impact は medium とした。再確認待ちの見逃しは出荷物の誤動作だが、直した版で再実行すれば報告は正しく
出直す。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

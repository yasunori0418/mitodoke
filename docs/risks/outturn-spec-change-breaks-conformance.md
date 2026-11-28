---
id: "RISK-34528968-f847-44ef-ad02-eddbaba6d254"
type: risk
name: "draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる"
description: "draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる"
likelihood: high
impact: medium
level: high
quality_characteristic: compatibility
section: result-handoff
status: stable
threatens:
  - "DSG-b70a4bcf-fa63-4b19-a123-1076b32df625"
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:11:46+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:03:56+09:00"
---
# draft の outturn の仕様が変わり、エンベロープが仕様に適合しなくなる

## リスク

outturn の仕様は draft で、タグも Rust の実装もまだ無い。その仕様が変わったときに、`--json` の
エンベロープが
[サブコマンドの --json は outturn のエンベロープを出し、既定の text 出力は変えない](../requirements/json-outturn-envelope.md)
の求める、§8 の `standalone` まで含めた適合を失う懸念である。外部への依存の risk で、失敗の向きは次の
2 つある。

- 仕様が変わり、変わる前の形のままのエンベロープが適合しなくなる
- 仕様に追随したときに、要件が決めた形（`results[]` を 1 つにする、`dryRun`・`changes[]`・`label` の
  決め方）が新しい仕様と両立しなくなる

最も重い向きは、変わる前の形のまま適合しなくなる向きで、この risk はこの向きで採点する。適合しない
エンベロープも JSON としては読めるので、受け取る側が新しい schema で確かめない限り誤りは表に出ない。
仕様が変わらないままサブコマンドごとに形が食い違う懸念は
[結果エンベロープの形がサブコマンドによって食い違う](envelope-shape-diverges-across-subcommands.md)
が持つ。

[結果エンベロープを outturn のモジュールで組み立てる](../design/result-envelope-assembly.md) への辺は、
outturn の crate に git のコミットで依存する設計に固有の面を指す。エンベロープの型は依存したコミットの
仕様に固定され、仕様の変化は crate を上げるまで届かない。上げたときも、型の変わらない規則の変化は
コンパイルを素通りする。crate に依らずに型を持つ設計へ差し替えれば、この面は消える。

## 実現性

likelihood は high とした。どちらの軸も、採点した向きで見る。変わりやすさは高い。outturn は draft で
仕様が変わりうるうえ、適合の規則は schema・リント・id のテストベクタ・`standalone` の 4 つにまたがり、
すべてのサブコマンドが同じエンベロープを共有する。見逃しやすさも高い。`--json` の出力のサンプルを
outturn の flake の `lib.mkSchemaCheck` で確かめると決めてあるが、その検査も、エンベロープに当たる
契約テストもまだ無い。検査ができても確かめるのは依存した版の schema で、仕様の変化は版を上げるまで
見えない。

impact は medium とした。適合しないエンベロープは出荷物の誤動作だが、追随した版を出し直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

---
id: "RISK-b66f195c-cf1f-49fc-88d9-a9837c2869ee"
type: risk
name: "new が generated.by の出どころの優先順位か、拒む値の判定を誤る"
description: "new が generated.by の出どころの優先順位か、拒む値の判定を誤る"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: authoring
status: stable
threatens:
  - "REQ-6ae12339-4f49-45f9-8b8a-b39d2da58a85"
  - "REQ-a69187a5-ad91-4cee-bf29-efa34e79f812"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:06:42+09:00"
---
# new が generated.by の出どころの優先順位か、拒む値の判定を誤る

## リスク

`new` が `generated.by` に書く値の出どころを取り違えるか、拒む値の判定を誤る懸念である。失敗の向きは次の
3 つある。

- [generated.by は環境変数か引数から取り、どちらも無ければ端末からの実行に限り人の識別子とする](../requirements/generated-by-source.md)
  の優先順位を誤り、引数 `--by` と環境変数 `MITODOKE_GENERATED_BY` の両方があるときに環境変数の値を書く
- [generated.by は自由な文字列とし、空の値と引用符・バックスラッシュ・改行を含む値だけを拒む](../requirements/generated-by-format.md)
  の判定を誤り、空の値か、`"`・`\`・改行を含む値を書く
- 同じ要件の判定を誤り、拒むべきでない値（`/` や空白を含む値など）で起票を拒むか、値の書式で判定を分ける

最も重い向きは、拒むべき値を書く向きで、この risk はこの向きで採点する。`"`・`\`・改行を含む値は、
frontmatter の二重引用符の中で YAML として壊れるか別の値に読まれ、その item をグラフから外す原因になる。
`check` が既存の item で同じ値を拒むので、判定を `new` と `check` で食い違わせると、`new` が通した item を
`check` が失敗にする。

端末からの実行でないのに `human:<id>` を作って書く向きは
[端末からの実行でないのに、人の確認や human: の generated.by を書く](human-record-written-without-terminal.md)
が持ち、`generated.at` の書式は
[時刻を文字列として比べるか、受け付ける書式を取りこぼし、検査と書き込みで時刻の扱いが食い違う](timestamp-misread-or-compared-as-string.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。出どころは引数・環境変数・端末からの実行に限る人の
識別子の 3 段で、拒む値の判定は `new` の入力と `check` の検査の 2 か所で共有する。見逃しやすさも高い。
写した `dev/tests/sara-new.sh` は、環境変数が無い場合・空の場合・二重引用符を含む場合に起票を拒むことを
確かめているが、採点した向きのうちバックスラッシュと改行の拒否は確かめていない。引数 `--by` と優先順位は
写した `dev/scripts/sara-new.sh` に無い。両方が高いときは high とする読み替えの規則に当てると high になる。
それでも medium としたのは、拒む値のうち空と二重引用符は確かめていて、残るバックスラッシュと改行も同じ
`expect_rejected` の確かめ方を写すだけで足せるためである。

impact は medium とした。誤った `generated.by` は出荷物の誤動作だが、値を直して再実行すれば回復できる。
書き込まれた item も git の差分に残るので、取り消せる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

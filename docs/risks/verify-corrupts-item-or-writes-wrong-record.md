---
id: "RISK-4a3f5500-55ca-4930-9bc9-34bfa416b055"
type: risk
name: "verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く"
description: "verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く"
likelihood: medium
impact: high
level: high
quality_characteristic: reliability
section: freshness
status: stable
threatens:
  - "REQ-47318ae1-da64-4e9e-9345-60f39648ff05"
  - "REQ-fa6eaf70-fdfb-4a93-9922-37ec17a625e6"
  - "REQ-423d8274-73e8-41d7-93d0-72bb4972e1c0"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:25+09:00"
---
# verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く

## リスク

`verify` が人の確認を書き込むときに、item を壊すか誤った記録を残す懸念である。失敗の向きは次の 3 つある。

- [verify は端末での人の入力があるときだけ人の確認を記録する](../requirements/human-verification-recording.md)
  の記録で、`verified` に要素を足すときに既存の要素やほかのキーを消すか、frontmatter を YAML として
  読めない形にする
- [人の確認に書く識別子は設定のコマンドの出力から取り、不正な出力では何も書かない](../requirements/human-id-command.md)
  が破れ、空・複数行・`"`・`\` を含む出力や、失敗したコマンドの出力を `human:<id>` に書く
- [item を指定しない verify は、対話で選んだ枝を上流から順にたどって人の確認を記録する](../requirements/interactive-verification-walk.md)
  の対話で、人が確認した item と別の item に確認を書く

最も重い向きは、人が確認していない item に確認を書く向きで、この risk はこの向きで採点する。書かれた
`human:` の要素は本物の人の確認と見分けが付かないので、誤りは表に出ない。端末からでない実行が確認を書く
懸念は
[端末からの実行でないのに、人の確認や human: の generated.by を書く](human-record-written-without-terminal.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。採点した向きでは、確認を書く item が、対話で選んだ枝の
item ごとに記録するか飛ばすかで決まり、item を指定する実行と対話の実行の 2 つの経路で決め方が分かれる。
見逃しやすさも高い。写した `dev/tests/sara-verify.sh` は対話の経路について、飛ばした item には何も書かない
こと、「記録する」を選んだ item の数だけ確認を書くこと、記録した item をその順にコミットすること、adr を
1 本選べばその 1 本だけを対象にすることを確かめている。写した `dev/scripts/sara-verify.sh` は item を指定
する経路を持たないので、その経路は確かめていない。両方が高いときは high とする読み替えの規則に当てると
high になる。それでも medium としたのは、item を決めたあとの書き込みは 2 つの経路で同じで、選んだ item
だけに書くことを対話の経路で確かめた確かめ方を、指定の経路にもそのまま写せるためである。

ほかの向きについては、`verified` に行を足すだけで削除しないこと、既存の要素と後ろのキーを保つこと、
要件の 5 つの拒む条件のうち不正な 4 通りの識別子では何も書かないことを確かめている。コマンドが失敗した
場合は確かめていない。

impact は high とした。人が確認していない item への確認は、後から見つけても本物の確認と区別して
取り除けず、再実行では回復できない。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

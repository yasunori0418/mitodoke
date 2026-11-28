---
id: "RISK-59e34329-93d8-4f98-bc15-b90fa3c3633c"
type: risk
name: "verify が確認の問いを表示せずに記録するか、枝を上流から順にたどらない"
description: "verify が確認の問いを表示せずに記録するか、枝を上流から順にたどらない"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: freshness
status: stable
threatens:
  - "REQ-73949e27-20a9-4df4-9265-a7d7048d22fe"
  - "REQ-423d8274-73e8-41d7-93d0-72bb4972e1c0"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:25+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:01:56+09:00"
---
# verify が確認の問いを表示せずに記録するか、枝を上流から順にたどらない

## リスク

`verify` が、人が確認するときに見るべきものを見せないまま記録させる懸念である。失敗の向きは次の 3 つある。

- [verify は、solution と use_case の確認を記録する前に確認の問いを表示する](../requirements/verify-shows-review-questions.md)
  が破れ、確認の問いを表示せずに記録するか、適用先の製品が足した問いを表示しない
- 同じ要件が破れ、問いの答えをグラフに書く
- [item を指定しない verify は、対話で選んだ枝を上流から順にたどって人の確認を記録する](../requirements/interactive-verification-walk.md)
  が破れ、選んだ枝の item を上流から順に表示しない

最も重い向きは、確認の問いを表示せずに記録する向きで、この risk はこの向きで採点する。記録は人の確認と
して残るが、確認の問いに照らした確認ではないので、記録の重みが下がったことは表に出ない。下流を先に
表示する向きは、上流の確認を前提にできないまま下流を確認させる。誤った item に確認を書く懸念は
[verify が frontmatter を壊すか、不正な識別子や誤った item に確認を書く](verify-corrupts-item-or-writes-wrong-record.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。問いは型ごとに `quality` の `review_question_for` から
読み、適用先の製品が足した問いを含め、表示は solution と use_case に限る。記録は item を指定する実行と
対話の実行の 2 つの経路を持つ。見逃しやすさも高い。写した `dev/tests/sara-verify.sh` は、対話の経路で
solution と use_case の問いを端末とエディタに出し、requirement には出さないこと、選んだ枝の経路と下流を
上流から幅優先で表示することを確かめている。写した `dev/scripts/sara-verify.sh` は item を指定する経路を
持たないので、その経路での問いの表示は確かめていない。フィクスチャは型ごとに問いの `quality` を 1 つしか
置かないので、適用先の製品が足した問いの表示も確かめていない。両方が高いときは high とする読み替えの規則に
当てると high になる。それでも medium としたのは、問いの表示は記録の直前に置く 1 つの処理で、対話の経路で
確かめた確かめ方を、item を指定する経路と問いが複数ある場合にそのまま写せるためである。

impact は medium とした。問いを見ずに書かれた確認は確認の質を下げるが、問いを見て確認し直せば記録を
足せる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。

---
id: "REQ-f319e7d0-8a0b-4c3f-92fc-b855e7e90652"
type: requirement
name: "組み込みの relation は上流の 8 つと peer の 3 つとし、保証する連鎖は requirement → risk → test_condition → test_case とする"
description: "組み込みの relation を上流の 8 つと peer の 3 つとし、relation ごとの張り元と張り先の型を定め、保証する連鎖を requirement → risk → test_condition → test_case として design を任意の中継点にする。"
specification: |
  The built-in relations SHALL be the eight upstream relations `refines`, `derives_from`,
  `satisfies`, `threatens`, `mitigates`, `covers`, `follows` and `justifies`, and the three peer
  relations `depends_on`, `supersedes` and `references`. Each built-in relation SHALL be
  declared only from the following source types to the following target types: `refines` from
  use_case to solution; `derives_from` from requirement to use_case, and from quality and
  test_plan to solution; `satisfies` from design to requirement and test_plan, and from
  infrastructure to quality and design; `threatens` from risk to requirement and design;
  `mitigates` from test_condition to risk; `covers` from test_case to test_condition; `follows`
  from test_case to test_plan; `justifies` from adr to requirement, design, infrastructure,
  quality and test_plan; `depends_on` from requirement, design, quality, test_plan and
  infrastructure to an item of the same type; `supersedes` and `references` from adr to adr.
  The guaranteed chain SHALL be requirement → risk → test_condition → test_case. design SHALL
  be an optional relay point of this chain: a requirement SHALL NOT be required to have a
  design, a design without a risk SHALL be treated as normal, and design SHALL NOT be counted
  in the indicators of uncovered items.
specification_ja: |
  組み込みの relation は、上流の relation `refines`・`derives_from`・`satisfies`・`threatens`・
  `mitigates`・`covers`・`follows`・`justifies` の 8 つと、peer の relation `depends_on`・`supersedes`・
  `references` の 3 つでなければならない。組み込みの relation は、次の張り元の型から張り先の型へだけ
  張れなければならない。`refines` は use_case から solution へ。`derives_from` は requirement から
  use_case へ、quality と test_plan から solution へ。`satisfies` は design から requirement と
  test_plan へ、infrastructure から quality と design へ。`threatens` は risk から requirement と
  design へ。`mitigates` は test_condition から risk へ。`covers` は test_case から test_condition へ。
  `follows` は test_case から test_plan へ。`justifies` は adr から requirement・design・infrastructure・
  quality・test_plan へ。`depends_on` は requirement・design・quality・test_plan・infrastructure から
  同じ型の item へ。`supersedes` と `references` は adr から adr へ。保証する連鎖は requirement →
  risk → test_condition → test_case でなければならない。design はこの連鎖の任意の中継点でなければ
  ならない。requirement に design を必須にしてはならず、risk を持たない design は正常としなければ
  ならず、未カバーの指標に design を数えてはならない。
section: model-config
status: stable
derives_from:
  - "UC-7575b60a-c45b-4d2c-9c88-3cf68a884a35"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:58:36+09:00"
---
# 組み込みの relation は上流の 8 つと peer の 3 つとし、保証する連鎖は requirement → risk → test_condition → test_case とする

## 仕様

組み込みの relation は、上流の relation 8 つと peer の relation 3 つとする。relation は、次の表の張り元の型から
張り先の型へだけ張れる。

| relation | 向き | 張り元の型 | 張り先の型 |
|---|---|---|---|
| `refines` | 上流 | `use_case` | `solution` |
| `derives_from` | 上流 | `requirement` | `use_case` |
| `derives_from` | 上流 | `quality`・`test_plan` | `solution` |
| `satisfies` | 上流 | `design` | `requirement`・`test_plan` |
| `satisfies` | 上流 | `infrastructure` | `quality`・`design` |
| `threatens` | 上流 | `risk` | `requirement`・`design` |
| `mitigates` | 上流 | `test_condition` | `risk` |
| `covers` | 上流 | `test_case` | `test_condition` |
| `follows` | 上流 | `test_case` | `test_plan` |
| `justifies` | 上流 | `adr` | `requirement`・`design`・`infrastructure`・`quality`・`test_plan` |
| `depends_on` | peer | `requirement`・`design`・`quality`・`test_plan`・`infrastructure` | 張り元と同じ型 |
| `supersedes` | peer | `adr` | `adr` |
| `references` | peer | `adr` | `adr` |

保証する連鎖は `requirement` → `risk` → `test_condition` → `test_case` とする。`design` はこの連鎖の任意の
中継点にする。

- `requirement` に `design` を必須にしない
- `risk` を持たない `design` は正常とする
- 未カバーの指標に `design` を数えない

## 出典

relation と、その張り元と張り先の型は `docs/model.yaml` が定める。保証する連鎖の決定は次の ADR が持つ。

- [保証する連鎖は requirement → risk → test_condition → test_case とし、design は任意の中継点にする](../adr/guaranteed-chain-design-optional.md)

# sara CLI の使い方

sara（と `sara-new` / `sara-gap` / `sara-fresh` / `sara-verify`）は **PATH に通っている前提**で `sara ...` と直接叩く
（direnv 等で開発シェルが読み込まれた環境なら通っている）。通っていなければ環境構築を
プロジェクトの規約に従って済ませてから使う。設定はカレント（リポジトリルート）の
`sara.toml` を読むため、**リポジトリルートで実行する**。

## sara-new — item の起票（採番 + frontmatter の生成）

frontmatter は手書き・テンプレ写経をせず `sara-new` で起票する。採番・ファイル名規約の
適用・`sara init` の呼び出しを一手で済ませる:

```bash
sara-new <型> <slug> <配置ディレクトリ> -- --description <要約> [<sara init のオプション>...]

export SARA_NEW_GENERATED_BY="claude-code/<モデル ID>"   # 人なら human:<GitHub ID>
sara-new risk lock-ordering docs/risks -- \
  --name "<日本語の 1 行要約>" \
  --description "<item の 1 文の要約>" \
  --section "<テストの区分>" \
  --threatens "<REQ / DSG のフル ID>" \
  --quality-characteristic reliability \
  --likelihood medium --impact high --level high
```

- 返るのは機械可読の 2 行（`id:` = 採番されたフル ID、`file:` = 起票したファイルのパス）。
- `--` 以降は `sara init` へそのまま渡る。型ごとのオプション（relation・固有フィールド）は
  `sara init <型> --help` で確認する。requirement / quality / test_plan の
  `--specification` / `--specification-ja`、
  `requirement` / `design` / `ubiquitous_term` / `adr` / `risk` の `--section`、
  test_case の `--resource` など、モデルの必須フィールドはここで渡す。
  `section` を持つ型で `--section`（`--section=…` でもよい）を省くと、`sara-new` は起票せず
  exit 2 で落ちる。値と index.md の見出しの対応は `dev/scripts/okf-index.sh` の表で確かめる
  （`risk` は `dev/tests/test-categories.tsv`）。
- `stale_after` を必須にする型（`solution`）で `--stale-after`（`--stale-after=…` でもよい）を省くと、`sara-new` は
  起票せず exit 2 で落ちる。`sara init` が `TBD` を書くためである。
- `quality_characteristic` を持つ型（`risk`）で `--quality-characteristic`（`--quality-characteristic=…` でもよい）を
  省くと、`sara-new` は起票せず exit 2 で落ちる。`sara init` が enum の先頭の値を入れるためである。取りうる値は
  `docs/model.yaml` にある `risk` の `quality_characteristic` の enum。
- `--` 以降に `--description`（`-d` / `--description=…` でもよい）が無ければ、起票せず exit 2 で
  落ちる。環境変数 `SARA_NEW_GENERATED_BY` が空か未設定のときも exit 2 で落ちる。どちらも
  ファイルを作らない。
- 起票した item の frontmatter の末尾（閉じの `---` の直前）に `generated` を付ける。`by` は
  `SARA_NEW_GENERATED_BY` の値、`at` は起票時の `date --iso-8601=seconds` の値（UTC オフセット付き）。
- ADR は `adr` で起票する（`--status` と `--section` を渡す）。
- 生成後に本文（`# <name>` の見出し + 散文）を書き足し、`sara check` で green
  を確認する。
- 既存 item のフィールド・relation の変更は `sara edit <フル ID> --<フィールド> ...`
  でもよい（対話モードは TTY 前提なので、非対話ではフラグを明示する）。

## check — グラフ検証

```bash
sara check                 # broken reference / duplicate ID / cycle / orphan
sara check --format json   # items 配列（宣言辺つき）を機械可読で出す
```

- item を書き込んだら必ず回す。green（exit 0）が完了条件。
- strict 有効（`sara.toml` の `strict_mode = true`）なら orphan を含む全 warning が
  error になる。orphan は「upstream relation の接続漏れ」を意味することが多い。
- `--format json` の `items[].relations`（relation 名 → 張り先 ID の配列）は**宣言辺
  （primary relation）のみ**で逆辺を持たない。逆引き（「この REQ を threatens している risk は?」）が要るときは
  `sara query -d` か `sara-gap` を使う。

## query — グラフを辿る

```bash
sara query <フル ID> -u    # 上流へ（例: requirement → use_case → solution）
sara query <フル ID> -d    # 下流へ（例: requirement → design、REQ ← risk ← TC ← CASE）
sara query <フル ID> -u --depth 1
sara query <フル ID> -d --format json
```

**`sara query` はフル ID しか受け付けない**が、frontmatter の `id:` と relation リストは
フル ID で書くので、そこからそのままコピーして渡せる（省略形からの復元は要らない）。
同じ文字列で grep すれば、宣言側（frontmatter の `id:`）と参照側（relation リスト）の
両方に当たる:

```bash
rg -l REQ-2b0c2bb8-964f-4e36-a121-c6ea0d4be1c4 docs/   # 宣言・参照元の列挙
```

## report — 俯瞰

```bash
sara report coverage   # 型ごとの coverage の集計（sara-gap の到達率とは別）
sara report matrix     # トレーサビリティマトリクス（--format json で機械可読）
```

工程固定の一覧文書を作らない代わりに、全体像はこの 2 つで取る。

## diff — 参照間の比較

```bash
sara diff <git-ref>    # 指定 ref とのグラフ差分（item / relation の増減）
```

PR レビューで「このブランチでグラフに何が増えたか」を見るときに使う。

## schema — モデルの確認

```bash
sara schema            # 有効な model schema を YAML で出力
```

型・relation・フィールド定義の正本は `docs/model.yaml`。編集前に schema で現状を確認する。

## sara-gap — 未カバーの 11 節と到達率（別コマンド）

```bash
sara-gap           # text: 11 節の見出し + <フル ID>\t<name>\t<file>
sara-gap --json    # {unthreatened, unmitigated, uncovered, unfollowed, unsatisfied_quality, exempt, reach,
                   #  use_case_without_requirement, requirement_under_deprecated_use_case,
                   #  quality_characteristic_without_risk, human_judgement}
```

| 節 | `--json` のキー | 内容 |
|---|---|---|
| 1 | `unthreatened` | `threatens` も `risk_exempt` も無い `requirement`。`design` は列挙しない。`design` 側にだけ `risk` があれば text の行末に `(design 側に risk あり)` を付ける |
| 2 | `unmitigated` | `mitigates` されていない `risk` |
| 3 | `uncovered` | `covers` されていない `test_condition` |
| 4 | `unfollowed` | `follows` を持たない `test_case` |
| 5 | `unsatisfied_quality` | `infrastructure` に `satisfies` されていない `quality` |
| 6 | `exempt` | `risk_exempt` を持つ `requirement`。情報として出し、exit code に影響しない |
| 7 | `reach` | `requirement` / `test_plan` / `quality` ごとの `{total, reached, ratio}` |
| 8 | `use_case_without_requirement` | 有効な `requirement` に `derives_from` されていない有効な `use_case`。`deprecated` の `requirement` しか持たないものも出す |
| 9 | `requirement_under_deprecated_use_case` | 有効な `requirement` のうち、親の `use_case` がすべて `deprecated` のもの。有効な親が 1 本でもあれば出さない |
| 10 | `quality_characteristic_without_risk` | ISO/IEC 25010:2023 の 9 特性のうち、どの有効な `risk` の `quality_characteristic` にも無く、対象外の TSV にも無い特性 |
| 11 | `human_judgement` | 値の空でない `human_judgement` を持つ有効な `test_condition`。人が最終的に判断するものの一覧として出し、exit code に影響しない |

節 1〜6・8・9・11 の `--json` の行は `{id, name, file}` で、`id` はフル ID。節 7 の text の行は
`<型>\t<reached>/<total>\t<割合>%`。節 10 の `--json` は特性の値（`security` など）の文字列の配列で、text の行は
特性の値を 1 行に 1 つ出す。

節 8〜11 の「有効な」は、`status` が `deprecated` でないことを指し、`draft` を含む。節 1〜7 は `deprecated` の
item も数える。

対象外の品質特性は特性と理由の 2 列のタブ区切りの TSV に書く。1 行目はヘッダとして読み飛ばす。パスは既定で
リポジトリの根からの `dev/tests/quality-characteristic-exclusions.tsv` で、環境変数 `SARA_GAP_EXCLUSIONS` で
差し替えられる。ファイルが無ければ、どの特性も対象外にしない。

到達と数えるのは次のもの。

- `requirement`: `risk_exempt` を持つものを `total` から除き、`requirement` ← `risk` ← `test_condition` ← `test_case` の辺がすべてつながるもの
- `test_plan`: 1 件以上の `test_case` から `follows` されるもの
- `quality`: 1 件以上の `infrastructure` から `satisfies` されるもの

exit code は、節 1〜5 と節 8〜10 のすべてが空で `ratio` がすべて 1 なら 0、それ以外は 1。`sara check` の失敗と
JSON 形状の異常は 2。

sara 本体ではなく devShell 同梱の独立コマンド。valid なグラフに対してだけ動く
（`sara check` が落ちる間は exit 2 で一覧を出さない）。工程スキルは着手点の特定に使う。

## 別コマンド sara-fresh による再確認待ち・generated の更新漏れ・人の確認の欠け・期限切れ・間隔の超過の列挙

```bash
sara-fresh                     # text: 節 1・節 3〜6 の見出し + 各行
sara-fresh --base main         # text: 節 1〜6 の見出し + 各行
sara-fresh --json [--base <ref>]  # {stale, generated_not_updated, unverified_high_risk,
                                  #  unverified_validation, expired, stale_after_beyond_interval}
```

| 節 | `--json` のキー | 内容 |
|---|---|---|
| 1 | `stale` | `refines` / `derives_from` / `satisfies` / `threatens` / `mitigates` / `covers` / `follows` で指している上流の `generated.at` が、自身の基準時刻より新しい item。text の行末に、その上流のフル ID をカンマ区切りで足す |
| 2 | `generated_not_updated` | `--base <ref>` を渡したときだけ出す。`git merge-base <ref> HEAD` のコミットと作業ツリーを比べ、本文が変わったのに `generated.at` の値が変わっていない item |
| 3 | `unverified_high_risk` | `level: high` の `risk` のうち、`by` が `human:` で始まり `at` が `generated.at` 以降の `verified` を持たないもの |
| 4 | `unverified_validation` | `solution` と `use_case` のうち、`by` が `human:` で始まり `at` が `generated.at` 以降の `verified` を持たないもの |
| 5 | `expired` | `stale_after` が現在時刻より前の item。型を問わない |
| 6 | `stale_after_beyond_interval` | 間隔の TSV に行のある型の item のうち、`stale_after` が起点から N 日より先のもの。起点は `generated.at` 以降で `by` が `human:` で始まる `verified[].at` のうち最も新しい時刻で、無ければ `generated.at` |

基準時刻は `generated.at` と `generated.at` 以降の `verified[].at`（actor を問わない）のうち最も新しい時刻。
`justifies` と peer の relation（`depends_on` / `supersedes` / `references`）は辿らない。`status: deprecated` の
item はどの節でも扱わない。

節 2 の本文は frontmatter の外の行で、`# ` で始まる H1 の行と `- ステータス:` で始まる行を除き、空白だけの差は
数えない。コードフェンスの中の `# ` で始まる行は H1 として除かず、本文として比べる。2 点の間で足した item と削除した item は比べない。base に同じパスが無い item は、同じ ID を持つ
base 側のファイルを旧パスとみなして比べる。未コミットの変更も比べる対象に入る。

`stale` の `--json` の要素は `{id, name, file, upstreams}` で、`upstreams` は上流ごとの
`{id, relation, at}`（`at` は上流の `generated.at`）。節 2〜6 の要素は `{id, name, file}`。`--base` を
渡さないとき、`--json` に `generated_not_updated` のキーは無い。

節 5 の現在時刻は環境変数 `SARA_FRESH_NOW`（UTC オフセット付きの ISO 8601）で差し替えられる。節 6 の間隔は
型と日数の 2 列のタブ区切りの TSV に書く。1 行目はヘッダとして読み飛ばす。パスは既定でリポジトリの根からの
`dev/tests/stale-after-intervals.tsv` で、環境変数 `SARA_FRESH_INTERVALS` で差し替えられる。ファイルが無ければ
節 6 の検査をしない。行の無い型も検査しない。期限を延ばすには、人の確認を `verified` に記録してから
`stale_after` を書き換える。

exit code は、出力したどの節も空なら 0、いずれかの節に item があれば 1。引数の誤り、`sara check` の失敗、
JSON 形状の異常、frontmatter を YAML として読めない item、`verified` がリストでない item、`generated.at`・
`verified` の `at`・`stale_after` を時刻として読めない item があるとき、`SARA_FRESH_NOW` を時刻として読めない
とき、`--base` の ref を解決できないとき、`--base` の ref と
HEAD の merge-base が無いときは、一覧を出さずに 2 を返す。結果は報告に留め、`verified` は人が内容を確かめた
ときにだけ、`sara-verify` か手で足す。CI の `sara` ジョブは pull_request で base ブランチを `--base` に渡して実行し、exit 1 では
落ちない。

## 別コマンド sara-verify による人の確認の記録（対話）

```bash
sara-verify        # 起点の型を選び、generated.at 以降の human: の verified を持たない item を順に確かめる
sara-verify --all  # human: の verified を持つ item も対象にする
```

人が端末で使うコマンドで、エージェントは実行しない。stdin と stdout のどちらかが端末でないと exit 2 で終わる。

- 起点の型: はじめに、`solution`・`adr`・`ubiquitous_term` のどこから確認するかを選ぶ。`adr` と `ubiquitous_term` は
  上流の relation を持たず、`solution` からは辿れないので、型の一覧から選ぶ
- `solution` の選ぶ手順: 子の item（その item を `refines` / `derives_from` / `satisfies` / `threatens` /
  `mitigates` / `covers` / `follows` で指している item）を `fzf` で 1 段ずつ選ぶ。どの段でも、いま選んでいる
  item で決められる。子の無い item まで降りると、そこで決まる
- 選ぶ候補: その item か下流に確認の対象が残っている子だけを出す。`status: deprecated` の item と、下流まで確認の対象が
  残っていない item は出さない。確認済みの item を出すときは「確認済み」の印を付ける（`--all` では確認済みの item も
  対象なので、下流まで確認済みの枝も出す）
- `adr` と `ubiquitous_term` の一覧: 確認の対象をファイル名の順に並べ、「すべてを順に確認する」か 1 本を選ぶ。
  `status: deprecated` の item と確認済みの item は出さない（`--all` では確認済みの item を、印を付けて出す）
- 確認の対象: 根から選んだ item までの経路と、選んだ item の下流のすべて。幅優先で並べ、同じ深さの中は ID の順にする。
  複数の親から届く item は最初の 1 度だけ対象にする。`status: deprecated` の item と、`generated.at` 以降の
  `human:` の `verified` を持つ item は外す（`--all` では後者も対象にする）。`deprecated` の item を経由してしか
  届かない item も対象にしない
- item ごとの流れ: `leaf <ファイル>` で表示し、閉じたら「記録する・飛ばす・中断する」を選ぶ。`solution` と `use_case`
  では選ぶ前に、`review_question_for` がその型を指す `quality` の item の確認の問い（`specification_ja`）を出す。
  「記録する」では `EDITOR` が開き、コメントを任意で書く。確認の問いは `#` で始まる行として載り、`#` で始まる行は
  コメントから除く。コメントが空でも記録する
- 記録: frontmatter の `verified` に `by: "human:<id>"` と `at`（UTC オフセット付きの ISO 8601 の現在時刻）の要素を
  足す。`verified` が無ければリストを作る。ほかの行と `generated` は変えない。`<id>` は環境変数
  `SARA_VERIFY_HUMAN_ID`、無ければ `gh api user --jq .login` の出力
- コミット: 対象を終えたとき、中断したとき（「中断する」と Ctrl-C）、item ごとの流れの途中で失敗したときに、
  記録した item をファイルごとに 1 コミットにする。
  件名は `docs(<型>): <ファイル名から .md を除いたもの>`、本文は入力したコメントで、空なら本文を書かない。
  現在のブランチにコミットし、ブランチの作成と push はしない

ビューアの `leaf` は dev flake に入れておらず、PATH から使う。エディタは環境変数 `EDITOR`（無ければ `vi`）。

exit code は対象を終えたときと「中断する」を選んだときは 0、Ctrl-C では 130。引数の誤り、端末でない、
`sara check` の失敗、`<id>` が空・複数行・二重引用符かバックスラッシュを含む・`gh` の失敗、対象のファイルに
未コミットの変更がある、`verified` がブロックのリストでない、`fzf`・`leaf`・`EDITOR`・コミットの失敗では 2。
item ごとの流れの途中で失敗したときは、そこまでの記録をコミットしてから終える。それより前の失敗では何も書かずに終える。

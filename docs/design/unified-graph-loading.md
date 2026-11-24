---
id: "DSG-4e5433cd-56bb-4008-a16b-f42f236f19c4"
type: design
name: "ドキュメントグラフの読み込みを 1 つの結果にまとめる"
description: "sara-core の読み込みと frontmatter を読む層を合わせた 1 つの読み込みの結果を作り、item の定義、読み飛ばしとモデルを読めないときの扱い、有効な item の判定をそこに置く"
section: product-scope
status: stable
satisfies:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-3fbd69bb-e638-40c2-b586-521e702b31d3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:34:32+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-24T23:33:17+09:00"
---
# ドキュメントグラフの読み込みを 1 つの結果にまとめる

## 設計

ドキュメントグラフの読み込みは、読み込みを 1 つにまとめるモジュールが持つ。このモジュールは、sara-core を
呼ぶモジュールの読み込みの結果と、frontmatter を読む層の結果を合わせて、1 つの読み込みの結果を作る。
どのサブコマンドも item をこの結果からだけ得て、frontmatter を別の読み方で読む箇所を作らない。

### item の定義

item は、sara-core の読み込み（`parse_directory`）が item として返したファイルである。mitodoke は、自分で
ディレクトリを走査しない。`.gitignore` に一致する追跡済みのファイルも、sara が読むなら item である。
mitodoke は、`.gitignore` で item を外す規則を足さない。

### frontmatter を読む層

frontmatter を YAML として読む層を 1 つ持つ。この層は、OKF のキー（`generated`・`verified`・
`stale_after`・`sources`）と宣言の無いキーを、型を問わずに読む。これらは sara-core が返す item に入らない
ので、この層の結果を合わせて、構造の契約の検査に渡す。

この層が読むのは、sara-core が item として返したファイルと、sara-core が読み飛ばしたファイルだけである。
読むファイルをこの 2 つに限るので、item の集合は sara-core の読み込みと同じままになる。読み飛ばした
ファイルも読むので、なぜ読めないかを示せる。

### 読み飛ばしとモデルを読めないときの扱い

読み飛ばし（scan warning）と、モデルを読めないことは、検査ではなく読み込みの前提として扱い、強さの設定の
対象にしない。sara-core の検証は読み飛ばしを受け取らないので、読み飛ばしを失敗にする判定は、読み込みを
1 つにまとめるモジュールが持つ。

| 起きたこと | `check` | ドキュメントグラフを読み込むほかのサブコマンド |
|---|---|---|
| ファイルを読み飛ばした | 読み飛ばしたファイルを、専用のコードを付けた `failed` の item で表し、exit 1 で終える | `new`・`index`・`gap`・`fresh`・`matrix`・`verify`・`export` は、処理を始めずに入力の誤りとして exit 2 で終える。`new` と `verify` は書き込みを拒む |
| モデルを読めない、またはモデルの install が失敗した | exit 2 で終える | exit 2 で終える |

- 読み飛ばしは、構造の契約・つながりの欠け・見直しの義務のどれにも入れない。読み飛ばしにも契約名を
  1 つ割り当て、その item の `kind` とコードをこの契約名から導く
- モデルを読めないときは、組み込みの型へ戻らない
- `init` と `model` はドキュメントグラフを読まないので、この扱いの対象にしない
- item が 0 件であること自体は、誤りにも該当にもしない。item が 0 件であることだけを理由に、exit code を
  0 以外にしない

### 有効な item の判定

[有効な item](../ubiquitous-language/active-item.md) を「`status` が `deprecated` でない item」と、読み込みを
1 つにまとめるモジュールの 1 か所で判定する。`draft` の item も有効な item である。検査と報告は、この判定を
次のように使い分ける。

- `check` の構造の契約は、`deprecated` の item にも働かせる
- `gap` と `fresh` は、すべての節で有効な item だけを数える。辺は、両端が有効な item のものだけを数える
- `index` は、[deprecated の item は index.md の末尾の節にまとめる](../adr/deprecated-items-listed-at-index-end.md)
  のとおりにする

## 出典

根拠の決定は次の ADR が持つ。

- [item は sara-core の読み込みが返したファイルとし、mitodoke は自分で走査しない](../adr/items-are-files-returned-by-sara-core-loader.md)
- [frontmatter を読む層を 1 つ持ち、読み込みを 1 つにまとめる](../adr/single-frontmatter-layer-and-unified-loading.md)
- [読み飛ばしは check を失敗させ、グラフを読むほかのサブコマンドを止める](../adr/scan-skips-fail-check-and-block-graph-commands.md)
- [モデルを読めなければ exit 2 で終え、組み込みの型へ戻らない](../adr/unreadable-model-exits-without-builtin-fallback.md)
- [有効な item だけを gap と fresh で数え、辺は両端が有効なものだけを数える](../adr/active-items-and-edges-counted-in-gap-and-fresh.md)
- [sara の検証の種類ごとに契約名を割り当て、kind とコードを契約名から導く](../adr/contract-name-per-sara-validation-kind.md)

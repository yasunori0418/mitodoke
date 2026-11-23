# mitodoke

*[English](README.md) で読む。*

> **mitodoke** — 要求から実装されたテストケースまで、品質に関する判断を人間が見届けるのを支える。

mitodoke は、ソフトウェア開発における品質活動を支援するプラットフォームです。品質について人間が検討する成果物（要求、要件、設計、リスク、テスト条件、テスト計画、テストケース）を構造化し、それらの関係を追跡可能にするとともに、上流の変更によって人間が再確認する必要のある下流成果物を検出します。

mitodoke は、誰かに代わって品質を保証するものではありません。評価し、判断し、確認し、責任を持つのは人間です。mitodoke は、特定し、関連付け、比較し、報告します。

> **状態: 設計段階（暫定の README）。** 設計は固まりましたが、まだ何も実装していません。このリポジトリにあるのは、Nix flake、開発用のシェル、CI だけです。[予定している形](#予定している形)の内容は変わることがあります。

## 名前

*mitodoke* は、日本語の **見届け**（最後まで見て、自分の目で確かめること）に由来します。見届けるのは、ツールではなく人間です。mitodoke は、確認すべき事項を示し、人間が確認したことを記録することで、この見届けを支えます。

## 予定している形

- **Rust で書く 1 つの CLI**。[SARA](https://github.com/cledouarec/sara) の `sara-core` を crate として組み込む。
- **設定ファイル `mitodoke.yaml`**。ここから SARA のモデル（`model.yaml`）と `sara.toml` を生成してコミットする。
- **サブコマンド**: `init`・`new`・`gap`・`fresh`・`index`・`matrix`・`model`・`verify`・`export`・`check`。`--json` の出力は [outturn](https://github.com/yasunori0418/outturn) の結果エンベロープに従う。
- **文書管理の規範とエージェント用のスキル**（`mitodoke-docs`・`mitodoke-test-plan`・`mitodoke-test-analyze`）を製品に含める。
- **Nix flake で配布**し、SARA の CLI も一緒に配る。

## ドキュメント

- [プロダクトコンセプト](docs/mitodoke-concept.ja.md)（[English](docs/mitodoke-concept.md)）

## 開発

開発用のシェルは `dev/flake.nix` で定義し、direnv で読み込みます。

```sh
cp example.envrc .envrc
direnv allow
```

direnv を使わない場合は `nix develop ./dev` を実行します。CI では `nix flake check` を実行します。

## ライセンス

[MIT](LICENSE)

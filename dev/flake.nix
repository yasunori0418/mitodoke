{
  description = "mitodoke development environment";

  inputs = {
    root.url = "path:../";
    nixpkgs.follows = "root/nixpkgs";
    flake-parts.follows = "root/flake-parts";

    # 個人 NUR。devShell に sara を載せるために引く。nixpkgs を follows で寄せず、
    # yasunori0418.cachix.org にあるビルド済み store path をそのまま使う。
    nur = {
      url = "github:yasunori0418/nur-packages";
    };

    # dev/skills/ のスキルを .claude/skills/ へ配置するのに使う。nur と同じく nixpkgs を follows で
    # 寄せず、yasunori0418.cachix.org にあるビルド済み store path をそのまま使う。
    layat = {
      url = "github:yasunori0418/layat";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = [
        inputs.layat.flakeModules.default
        # dev/skills/ を .claude/skills/ へ配置する config（perSystem.layat.skills）。
        ./layat.nix
      ];
      perSystem =
        { inputs', pkgs, ... }:
        let
          # dev/tests/term-avoid.sh が avoid の綴りの検出に使う。
          textlint = pkgs.textlint.withPackages [ pkgs.textlint-rule-prh ];

          # sara init を包む item 起票ラッパー。
          #
          #   sara-new <型> <slug> <配置ディレクトリ> -- --description <要約> [<sara init のオプション>...]
          #
          # 実体の dev/scripts/sara-new.sh を PATH に載せる薄い wrapper。
          sara-new = pkgs.writeShellApplication {
            name = "sara-new";
            runtimeInputs = [
              inputs'.nur.packages.sara
              # date / mkdir / mv / rm / tr。
              pkgs.coreutils
              # ID 行の抽出に使う。
              pkgs.gnused
              # frontmatter の閉じの直前へ generated を足すのに使う。
              pkgs.gawk
              # 下の text が exec するインタプリタ自身。
              pkgs.bash
            ];
            text = ''
              exec bash ${./scripts/sara-new.sh} "$@"
            '';
          };

          # sara ドキュメントグラフの未カバーを列挙する決定論コマンド。
          #
          #   sara-gap [--json]
          #
          # 実体の dev/scripts/sara-gap.sh を PATH に載せる薄い wrapper。
          sara-gap = pkgs.writeShellApplication {
            name = "sara-gap";
            runtimeInputs = [
              inputs'.nur.packages.sara
              pkgs.jq
              pkgs.coreutils
              # sara.toml のある走査基点をリポジトリルート基準で解決するため。
              pkgs.git
              # 下の text が exec するインタプリタ自身。
              pkgs.bash
            ];
            text = ''
              exec bash ${./scripts/sara-gap.sh} "$@"
            '';
          };

          # 上流より古い item・`--base` の ref からの generated の更新漏れ・人の確認が無い high の risk を列挙する決定論コマンド。
          #
          #   sara-fresh [--json] [--base <ref>]
          #
          # 実体の dev/scripts/sara-fresh.sh を PATH に載せる薄い wrapper。
          sara-fresh = pkgs.writeShellApplication {
            name = "sara-fresh";
            runtimeInputs = [
              inputs'.nur.packages.sara
              pkgs.jq
              # frontmatter の generated / verified を読む yq-go（mikefarah/yq v4）。
              pkgs.yq-go
              # frontmatter を 1 本の multi-document にまとめるのに使う。
              pkgs.gawk
              pkgs.coreutils
              # sara.toml のある走査基点をリポジトリルート基準で解決するため。
              pkgs.git
              # 下の text が exec するインタプリタ自身。
              pkgs.bash
            ];
            text = ''
              exec bash ${./scripts/sara-fresh.sh} "$@"
            '';
          };

          # 枝を選んで上流から順に item を表示し、人の確認を verified に記録する対話のコマンド。
          #
          #   sara-verify [--all]
          #
          # 実体の dev/scripts/sara-verify.sh を PATH に載せる薄い wrapper。ビューアの leaf は flake に入れず、PATH から使う。
          sara-verify = pkgs.writeShellApplication {
            name = "sara-verify";
            runtimeInputs = [
              inputs'.nur.packages.sara
              pkgs.jq
              # frontmatter の generated / verified を読む yq-go（mikefarah/yq v4）。
              pkgs.yq-go
              # frontmatter を 1 本の multi-document にまとめ、verified へ要素を足すのに使う。
              pkgs.gawk
              pkgs.coreutils
              pkgs.gnugrep
              # リポジトリルートの解決・未コミットの変更の確認・記録のコミット。
              pkgs.git
              # 枝と、記録するかどうかを選ぶ。
              pkgs.fzf
              # SARA_VERIFY_HUMAN_ID が無いときに <id> を gh api user で得る。
              pkgs.gh
              # 下の text が exec するインタプリタ自身。
              pkgs.bash
            ];
            text = ''
              exec bash ${./scripts/sara-verify.sh} "$@"
            '';
          };
        in
        {
          devShells = {
            # ローカル開発用: LSP・linter・formatter フル搭載
            default = pkgs.mkShell {
              packages = with pkgs; [
                statix # Nix linter
                nixd # Nix language server
                inputs'.root.formatter # root の treefmt formatter を再利用
                inputs'.nur.packages.sara # ドキュメント間の関連性の記述・検証
                # item 起票ラッパー（sara init + 規約どおりの rename）。
                sara-new
                # グラフ未カバーと到達率の列挙。
                sara-gap
                # 再検証待ちの item・generated の更新漏れ・人の確認が無い high の risk の列挙。
                sara-fresh
                # 枝を選んで人の確認を記録する対話のコマンド。
                sara-verify
                # CASE frontmatter を読む yq-go（mikefarah/yq v4）。python-yq とは別実装。
                yq-go
                # test-doc-matrix.sh が sara report matrix --format json を整形するのに使う。
                jq
                # dev/skills/ のスキルを .claude/skills/ へ配置する。
                inputs'.layat.packages.layat
              ];
              shellHook = ''
                export REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel)
                # dev/skills/ を .claude/skills/ に配置する。競合したら待たずに skip する。
                layat apply skills -f "$REPO_ROOT/dev" --no-wait
              '';
            };

            # CI の sara check と dev/tests/ の各テスト専用シェル。
            sara = pkgs.mkShell {
              packages = [
                inputs'.nur.packages.sara
                sara-new
                sara-gap
                sara-fresh
                sara-verify
                # 以下は dev/tests/ の各テストが使う。
                pkgs.git
                pkgs.gnused
                pkgs.coreutils
                # dev/tests/sara-new.sh が fixture の残存ファイルを数えるのに使う。
                pkgs.findutils
                pkgs.gnugrep
                # dev/tests/test-doc-map.sh が CASE frontmatter を読む yq-go（mikefarah/yq v4）。
                pkgs.yq-go
                # dev/tests/sara-gap.sh が --json 出力のアサーションに使う。
                pkgs.jq
                # dev/tests/term-avoid.sh が avoid の綴りを検出する。
                textlint
              ];
              env.TERM = "dumb";
            };

            # CI 用: 最小構成 + TERM=dumb
            ci = pkgs.mkShell {
              packages = [ ];
              env = {
                TERM = "dumb";
              };
              shellHook = ''
                export REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel)
              '';
            };
          };
        };
    };
}

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
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { inputs', pkgs, ... }:
        {
          devShells = {
            # ローカル開発用: LSP・linter・formatter フル搭載
            default = pkgs.mkShell {
              packages = with pkgs; [
                statix # Nix linter
                nixd # Nix language server
                inputs'.root.formatter # root の treefmt formatter を再利用
                inputs'.nur.packages.sara # ドキュメント間の関連性の記述・検証
              ];
              shellHook = ''
                export REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel)
              '';
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

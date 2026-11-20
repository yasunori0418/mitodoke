# dev/skills/ のスキルを .claude/skills/<name> へ配置する layat の config。
# `layat apply skills -f <dev flake>` で配置する（default の devShell の shellHook が実行する）。
{ inputs, ... }:
let
  layatLib = inputs.layat.lib;

  # dev/skills/ は編集をすぐ反映させるため、root 相対の可変 symlink で張る。
  devSkillEntries = builtins.listToAttrs (
    map
      (name: {
        name = ".claude/skills/${name}";
        value.src = layatLib.mkRootRelativeSymlink "dev/skills/${name}";
      })
      (
        builtins.attrNames (
          inputs.nixpkgs.lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./skills)
        )
      )
  );
in
{
  perSystem =
    { pkgs, ... }:
    {
      # flake.layat.<system>.skills へ転置される。
      layat.skills = layatLib.mkManifest {
        inherit pkgs;
        root = layatLib.projectRoot;
        entries = devSkillEntries;
      };
    };
}

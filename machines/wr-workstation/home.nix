{ config, pkgs, ... }:

let
  cfg = config.mynix;

in
{
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/bazel.nix
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/go.nix
      ../../home/programs/dev/js.nix
      ../../home/programs/dev/proto.nix
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
      ../../home/programs/dev/asm.nix
    ];

    home.packages = with pkgs; [
      brave
      debian-hostname
      zoom-us
      arcanist
      dbeaver
      feishu
      coscli
      leetcode-cli
    ];

    programs.git = {
      userName = "guangqing.chen";
      userEmail = "guangqing.chen@weride.ai";
    };
  };
}

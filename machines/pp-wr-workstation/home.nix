{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/bazel.nix
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/go.nix
      ../../home/programs/dev/js.nix
      ../../home/programs/dev/proto.nix
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    mynix.zsh.prompt_style = "lean";

    home.packages = with pkgs; [
      debian-hostname zoom-us arcanist dbeaver feishu
    ];

    programs.git = {
      userName = "Jingpiao Chen";
      userEmail = "jingpiao.chen@weride.ai";
    };
  };
}

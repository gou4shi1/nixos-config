{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/bazel.nix
      ../../home/programs/dev/cpp.nix
    ];

    home.packages = with pkgs; [
      debian-hostname zoom-us
    ];

    programs.git = {
      userName = "Jingpiao Chen";
      userEmail = "jingpiao.chen@weride.ai";
    };
  };
}

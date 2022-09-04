{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/bazel.nix
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/js.nix
      ../../home/programs/dev/proto.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      debian-hostname zoom-us arcanist dbeaver feishu coscli
    ];

    programs.git = {
      userName = "guangqing.chen";
      userEmail = "guangqing.chen@weride.ai";
    };
  };
}

{ lib, config, pkgs, ... }:

let
  cfg = config.mynix;

in
{
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      clang
      python3
      claude-code
      wechat-uos
    ];

    programs.git.settings.user = {
      name = "Guangqing Chen";
      email = "hi@goushi.me";
    };
  };
}

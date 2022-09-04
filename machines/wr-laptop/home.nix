{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      zoom-us feishu
    ];

    programs.git = {
      userName = "Guangqing Chen";
      userEmail = "hi@goushi.me";
    };
  };
}

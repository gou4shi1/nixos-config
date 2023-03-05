{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      zoom-us feishu nomachine dbeaver
    ];

    programs.git = {
      userName = "Guangqing Chen";
      userEmail = "hi@goushi.me";
    };
  };
}

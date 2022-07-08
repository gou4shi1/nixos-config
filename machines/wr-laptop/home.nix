{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    home.packages = with pkgs; [
      zoom-us feishu
    ];

    programs.git = {
      userName = "Guangqing Chen";
      userEmail = "hi@goushi.me";
    };
  };
}

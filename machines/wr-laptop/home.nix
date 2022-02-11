{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    programs.git = {
      userName = "Guangqing Chen";
      userEmail = "hi@goushi.me";
    };
  };
}

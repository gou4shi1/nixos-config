{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    home.packages = with pkgs; [
      debian-hostname
    ];

    programs.git = {
      userName = "guangqing.chen";
      userEmail = "guangqing.chen@weride.ai";
    };
  };
}

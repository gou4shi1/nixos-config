{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    programs.git = {
      userName = "Aria";
      userEmail = "461863631@qq.com";
    };
  };
}

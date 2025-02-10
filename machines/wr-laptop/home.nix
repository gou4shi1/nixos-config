{ config, pkgs, ... }:

let
  cfg = config.mynix;

in
{
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      lenovo-legion
      zoom-us
      feishu
      wechat-uos
    ];

    programs.git = {
      userName = "Guangqing Chen";
      userEmail = "hi@goushi.me";
    };
  };
}

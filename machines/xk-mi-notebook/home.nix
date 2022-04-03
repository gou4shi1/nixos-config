{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/go.nix
    ];

    home.packages = with pkgs; [
      typora krita
    ];

    programs.git = {
      userName = "Aria";
      userEmail = "461863631@qq.com";
    };

    # Add japanese input method.
    i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    xdg.configFile."fcitx5/profile".source = ./fcitx-profile;
  };
}

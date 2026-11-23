{ lib, config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/go.nix
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      clang python3 feishu dbeaver-bin openssl nmap marktext
      wechat-uos qq
    ];

    # Add japanese input method.
    i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    xdg.configFile."fcitx5/profile".enable = false;

    programs.kitty = {
      font = {
        name = "Mononoki Nerd Font";
        size = 15;
      };
    };

    xfconf.settings = {
      xfce4-power-manager = {
        "xfce4-power-manager/dpms-on-ac-off".value = lib.mkForce 30;
        "xfce4-power-manager/dpms-on-ac-sleep".value = lib.mkForce 25;
        "xfce4-power-manager/dpms-on-battery-off".value = lib.mkForce 30;
        "xfce4-power-manager/dpms-on-battery-sleep".value = lib.mkForce 25;
      };
      xfce4-screensaver = {
        "saver/idle-activation/delay" = lib.mkForce 15;
      };
    };
  };
}

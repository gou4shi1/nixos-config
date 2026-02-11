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
      python3 feishu dbeaver-bin openssl nmap marktext mpv wechat-uos
    ];

    home.sessionPath = [
      "$HOME/.local/bin"
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

    dconf.settings = {
      "com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
        font = "Mononoki Nerd Font 15";
        background-transparency-percent = lib.mkForce 10;
        dim-transparency-percent = lib.mkForce 5;
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

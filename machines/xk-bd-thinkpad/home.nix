{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/go.nix
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      python3 feishu dbeaver
    ];

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.zsh = {
      shellAliases = {
        rg = "rg -S";
      };
    };

    # Add japanese input method.
    i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    xdg.configFile."fcitx5/profile".source = ./fcitx-profile;

    dconf.settings = {
      "com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
        font = "Mononoki Nerd Font 15";
      };
    };
  };
}

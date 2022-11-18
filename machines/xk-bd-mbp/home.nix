{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/go.nix
    ];

    home.packages = with pkgs; [
      python38
    ];

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.zsh = {
      shellAliases = {
        rg = "rg -S";
      };
    };
  };
}

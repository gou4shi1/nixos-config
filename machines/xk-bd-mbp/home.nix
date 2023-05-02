{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/go.nix
    ];

    home.packages = with pkgs; [
      python3
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

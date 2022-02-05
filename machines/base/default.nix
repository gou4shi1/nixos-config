{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager";
    ref = "release-21.11";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import ../../overlays)
    ];
  };

in {
  inherit nixpkgs;

  imports = [
    "${home-manager}/nixos"
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    unzip
    vimHugeX
    firefox
  ];

  programs.zsh = {
    enable = true;
    # Only call `compinit` in local config to save init time.
    enableGlobalCompInit = false;
  };

  home-manager.users.guangqing = {
    inherit nixpkgs;

    imports = [
      ../../home/i18n/input-method/fcitx
      ../../home/programs/tilix
      ../../home/programs/zsh
      ../../home/programs/shell-tools
      ../../home/programs/git
      ../../home/programs/i3
      ../../home/themes
    ];
  };

  environment = {
    sessionVariables = {
      TERMINAL = [ "tilix" ];
    };
    variables = {
      EDITOR = "vim";
    };
  };
}

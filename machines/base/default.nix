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

  environment.systemPackages = with pkgs; [
    git
    wget
    unzip
    vimHugeX
    firefox
  ];

  programs.zsh.enable = true;

  home-manager.users.guangqing = {
    inherit nixpkgs;

    imports = [
      ../../home/programs/tilix
      ../../home/programs/zsh
      ../../home/programs/shell-tools
      ../../home/programs/git
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

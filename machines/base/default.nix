{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager";
    ref = "release-21.11";
  };

in {
  imports = [
    "${home-manager}/nixos"
  ];

  nixpkgs.overlays = [
    (import ../../overlays)
  ];

  environment.systemPackages = with pkgs; [
    git
    wget
    vimHugeX
    firefox
  ];

  programs.zsh.enable = true;

  home-manager.users.guangqing = {
    imports = [
      ../../home/programs/tilix
      ../../home/programs/zsh
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

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager";
    ref = "release-21.05";
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
    tilix
  ];

  programs.zsh.enable = true;

  home-manager.users.guangqing = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
    };
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

{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
  machineType = cfg.machineType;
  enableDesktop = cfg.desktop.enable;

  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager";
    ref = "release-21.11";
  };

  power-manager-config = import ../../home/services/xfce-power-manager { inherit lib; inherit machineType; inherit enableDesktop; };

in {
  imports = [
    "${home-manager}/nixos"
    ../../modules/users
    ../../modules/desktop
    ../../modules/docker
    ../../modules/mounts
    ./options.nix
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import ../../overlays)
    ];
  };

  # Enable the temperature management daemon.
  services.thermald.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    git wget unzip tree htop-vim vimHugeX
    firefox google-chrome gparted
  ];

  # My TRaceroute: a network diagnostic tool that combines the functionality of traceroute and ping.
  programs.mtr.enable = true;

  programs.zsh = {
    enable = true;
    # Only call `compinit` in local config to save init time.
    enableGlobalCompInit = false;
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/i18n/input-method/fcitx
      ../../home/programs/tilix
      ../../home/programs/zsh
      ../../home/programs/shell-tools
      ../../home/programs/git
      ../../home/programs/i3
      ../../home/programs/vim
      ../../home/themes
      power-manager-config
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

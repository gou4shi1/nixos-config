{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
  machineType = cfg.machineType;
  enableDesktop = cfg.desktop.enable;

  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager";
    ref = "release-23.05";
  };

  power-manager-config = import ../../home/services/xfce-power-manager { inherit machineType; };

in {
  imports = [
    "${home-manager}/nixos"
    ../../modules/users
    ../../modules/desktop
    ../../modules/virtualisation
    ../../modules/mounts
    ./options.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      # To protect nix-shell against garbage collection.
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-9.4.4"  # For typora.
        "openssl-1.1.1u"
      ];
    };
    overlays = [
      (import ../../overlays)
    ];
  };

  # To install documentation targeted at developers.
  documentation.dev.enable = true;

  # Enable the temperature management daemon.
  services.thermald.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
    };
    extraConfig = ''
      AcceptEnv VTE_VERSION
    '';
  };

  programs.ssh = {
    extraConfig = ''
      SendEnv VTE_VERSION
    '';
  };

  environment.systemPackages = with pkgs; [
    git wget zip unzip file tree htop-vim vimHugeX
    man-pages man-pages-posix
    firefox google-chrome gparted
    inetutils dnsutils
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
    home.stateVersion = "23.05";

    home.homeDirectory = "/home/${cfg.mainUser}";
    home.username = "${cfg.mainUser}";

    imports = [
      ../../home/programs/zsh
      ../../home/programs/shell-tools
      ../../home/programs/git
      ../../home/programs/vim
      ../../home/programs/dev/nix.nix
    ] ++ lib.optionals enableDesktop [
      power-manager-config
      ../../home/services/xfce-session
      ../../home/themes
      ../../home/i18n/input-method/fcitx
      ../../home/programs/i3
      ../../home/programs/tilix
      ../../home/programs/office
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

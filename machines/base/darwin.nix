{ config, pkgs, ... }:

let
  cfg = config.mynix;

  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/refs/heads/release-25.11.zip";
    sha256 = "1kqxy6r4ahnbazmpa4pncdp62najdikdaw8hvrv8nl6qxvbmf9fy";
  };

in {
  imports = [
    "${home-manager}/nix-darwin"
    ../../modules/users/darwin.nix
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      options   = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-9.4.4"  # For typora.
        "openssl-1.1.1w"
      ];
    };
    overlays = [
      (import ../../overlays)
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git wget zip unzip file tree htop-vim vim-darwin
  ];

  programs.zsh.enable = true;

  home-manager.useGlobalPkgs = true;

  home-manager.users."${cfg.mainUser}" = {
    home.stateVersion = "25.11";

    home.homeDirectory = "/home/${cfg.mainUser}";
    home.username = "${cfg.mainUser}";

    imports = [
      ../../home/programs/zsh
      ../../home/programs/shell-tools
      ../../home/programs/git
      ../../home/programs/vim
    ];
  };

  environment = {
    variables = {
      EDITOR = "vim";
    };
  };
}

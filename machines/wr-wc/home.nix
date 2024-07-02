{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.username = "guangqing-chen";
  home.homeDirectory = "/home/guangqing-chen";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      auto-optimise-store = true;
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
        "openssl-1.1.1w"
      ];
    };
    overlays = [
      (import ../../overlays)
    ];
  };

  imports = [
    ./sensitive.nix
    ../../home/programs/zsh
    ../../home/programs/shell-tools
    ../../home/programs/git
    ../../home/programs/vim
    ../../home/programs/dev/nix.nix
    ../../home/programs/dev/shell.nix
    ../../home/programs/dev/asm.nix
  ];

  home.packages = (with pkgs; [
    htop-vim
  ]) ++ (with pkgs.python3Packages; [
    ipython
  ]);

  home.sessionVariables = {
    VTE_VERSION = "7402";
  };

  home.sessionPath = [
    "/opt/phacility/arcanist/bin"
  ];

  programs.zsh = {
    history.path = "/mnt/data/.zsh_history";

    initExtraFirst = ''
      proxy_file=$(mktemp)
      sed -n '/# BEGIN Set http_proxy/,/# END Set http_proxy/p' /etc/bash.bashrc > $proxy_file
      source $proxy_file
    '';
  };
}

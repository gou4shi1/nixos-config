{ config, pkgs, ... }:

{
  imports = [
    ../base/darwin.nix
    ./home.nix
    ./sensitive.nix
  ];

  nix.settings = {
    substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "/opt/mynix/machines/xk-bd-mbp/default.nix";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

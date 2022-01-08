{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ../../overlays)
  ];

  environment.systemPackages = with pkgs; [
    git
    wget
    vimHugeX
    firefox
    kitty
  ];

  environment.variables.EDITOR = "vim";
  environment.sessionVariables.TERMINAL = [ "kitty" ];
}

{ config, lib, pkgs, ... }:

let

in {
  imports = [
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    tilix
  ];
}

{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}

{ config, lib, pkgs, ... }:

let

in {
  programs.go = {
    enable = true;
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
}

{ config, lib, pkgs, ... }:

let

in {
  programs.go = {
    enable = true;
    goPath = "go";
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
}

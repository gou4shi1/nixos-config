{ config, lib, pkgs, ... }:

let

in {
  programs.go = {
    enable = true;
    goPath = "go";
    package = pkgs.go_1_18;
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
}

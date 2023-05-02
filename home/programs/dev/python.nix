{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs.python3Packages; [
    ipython
    pipx
    yapf
    isort
  ];
}

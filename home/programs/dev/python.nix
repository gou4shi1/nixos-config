{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs.python3Packages; [
    # pipx
    ipython
    yapf
    isort
  ];
}

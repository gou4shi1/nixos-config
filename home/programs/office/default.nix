{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    libreoffice sioyek
  ];
}

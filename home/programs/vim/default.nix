{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    pack nodejs shellcheck rnix-lsp
  ];
}

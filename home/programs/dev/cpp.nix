{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    clang_13
    clang-tools
    pkg-config
    gnumake
    ninja
    cmake
    gdb
  ];
}

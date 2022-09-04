{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    clang_14
    clang-tools_14
    pkg-config
    gnumake
    ninja
    cmake
    gdb
    weggli
  ];
}

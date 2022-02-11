{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    clang_13
    clang-tools
    gnumake
    ninja
    cmake
    gdb
  ];
}

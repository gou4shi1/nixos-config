{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang_16
    clang-tools_16
    clangd
    pkg-config
    gnumake
    ninja
    cmake
    gdb
    weggli
  ];
}

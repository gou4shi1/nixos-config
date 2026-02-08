{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang
    clang-tools
    clangd
    pkg-config
    gnumake
    ninja
    cmake
    gdb
    # pwndbg
    gdbgui
    weggli
  ];
}

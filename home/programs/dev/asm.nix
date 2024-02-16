{ pkgs, ... }:

{
  home.packages = with pkgs; [
    asm-lsp
  ];
}

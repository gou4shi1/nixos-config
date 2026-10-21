{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    neovim
    tree-sitter
    lua-language-server
    typos-lsp
  ] ++ (if stdenv.isDarwin then [ vim-darwin ] else [ vim-full ]);

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

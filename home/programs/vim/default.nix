{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    pack # A plugins manager.
    nodejs # For CoC.
    universal-ctags # A maintained ctags implementation.
    global # Gtags, a global source code tagging system.
    rnix-lsp # A language server for Nix.
    typos # A source code spell checker.
  ] ++ (if stdenv.isDarwin then [ vim-darwin ] else [ vimHugeX ]);

  home.sessionVariables = {
    EDITOR = "vim";
  };
}

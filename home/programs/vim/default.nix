{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    pack # A plugins manager.
    nodejs # For CoC.
    universal-ctags # A maintained ctags implementation.
    global # Gtags, a global source code tagging system.
    shellcheck # A shell script analysis tool.
    rnix-lsp # A language server for Nix.
  ] ++ (if stdenv.isDarwin then [ vim-darwin ] else [ vimHugeX ]);

  home.sessionVariables = {
    EDITOR = "vim";
  };
}

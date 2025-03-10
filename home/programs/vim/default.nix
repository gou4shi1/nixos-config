{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    pack # A plugins manager.
    nodejs # For CoC.
    universal-ctags # A maintained ctags implementation.
    global # Gtags, a global source code tagging system.
    typos # A source code spell checker.
    neovim
    lua-language-server
  ] ++ (if stdenv.isDarwin then [ vim-darwin ] else [ vimHugeX ]);

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

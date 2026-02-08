{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    neovim
    lua-language-server
    nodejs_22 # For CoC.
    typos # A source code spell checker.
    universal-ctags # A maintained ctags implementation.
    global # Gtags, a global source code tagging system.
  ] ++ (if stdenv.isDarwin then [ vim-darwin ] else [ vim-full ]);

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

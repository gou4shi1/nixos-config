{ config, lib, pkgs, ... }:

let

in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "z" "extract" "sudo" "colored-man-pages" "history-substring-search"
      ];
      theme = "agnoster";
    };
  };
}

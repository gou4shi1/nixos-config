{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    ripgrep highlight bfs
  ];

  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden";
    defaultOptions = [ "--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" ];
    fileWidgetCommand = "rg --files --hidden";
    fileWidgetOptions = [ "--height 40%" "--layout=reverse" "--preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'" ];
    changeDirWidgetCommand = "bfs -type d -nohidden | sed s#^\\./##";
  };
}

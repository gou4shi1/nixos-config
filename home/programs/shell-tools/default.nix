{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    ripgrep highlight bfs nix-output-monitor
  ];

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden";
    defaultOptions = [ "--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" ];
    fileWidgetCommand = "rg --files --hidden";
    # TODO: change highlight to bat as https://github.com/sharkdp/bat/issues/357#issuecomment-555971886
    fileWidgetOptions = [ "--height 40%" "--layout=reverse" "--preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'" ];
    changeDirWidgetCommand = "bfs -type d -nohidden | sed s#^\\./##";
  };
}

{ config, lib, pkgs, ... }:

let

in {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 14;
    };
    shellIntegration.mode = "no-complete";
    settings = {
      # solarized-dark from https://terminal.sexy
      background = "#002b35";
      foreground = "#93a1a1";
      selection_background = "#81908f";
      selection_foreground = "#002831";
      color0 = "#002b36";
      color1 = "#dc322f";
      color2 = "#859900";
      color3 = "#b58900";
      color4 = "#268bd2";
      color5 = "#6c71c4";
      color6 = "#2aa198";
      color7 = "#93a1a1";
      color8 = "#657b83";
      color9 = "#dc322f";
      color10 = "#859900";
      color11 = "#b58900";
      color12 = "#268bd2";
      color13 = "#6c71c4";
      color14 = "#2aa198";
      color15 = "#fdf6e3";
      # background image
      background_image = "/opt/terminal-wallpaper.jpg";
      background_image_layout = "cscaled";
      background_opacity = "0.2";
      background_tint = "0.3";
      # windows
      enabled_layouts = "tall,fat,grid,horizontal,vertical";
      inactive_text_alpha = "0.9";
      notify_on_cmd_finish = "unfocused 30";
      # scrollback
      scrollback_lines = 5000;
      # cursor
      cursor = "#93a1a1";
      cursor_blink_interval = 0;
      # mouse
      mouse_hide_wait = "-1";
      # script
      allow_remote_control = "yes";
    };
    extraConfig = ''
      map f11 toggle_fullscreen
    '';
  };

  programs.zsh = {
    shellAliases = {
      s = "kitten ssh";
    };
  };
}

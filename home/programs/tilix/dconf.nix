# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;

in {
  dconf.settings = {
    "com/gexperts/Tilix" = {
      app-title = "\${appName}: \${activeTerminalTitle}";
      auto-hide-mouse = true;
      background-image-mode = "scale";
      control-click-titlebar = false;
      control-scroll-zoom = true;
      enable-wide-handle = true;
      focus-follow-mouse = false;
      middle-click-close = true;
      paste-advanced-default = false;
      prompt-on-close = true;
      prompt-on-delete-profile = true;
      prompt-on-new-session = false;
      sidebar-on-right = true;
      terminal-title-style = "none";
      unsafe-paste-alert = false;
      window-save-state = false;
      window-state = 0;
      window-style = "disable-csd-hide-toolbar";
    };

    "com/gexperts/Tilix/keybindings" = {
      session-add-down = "<Primary><Shift>d";
      session-add-right = "<Primary><Shift>r";
      terminal-advanced-paste = "disabled";
      terminal-insert-password = "<Primary><Alt>e";
    };

    "com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
      background-color = "#002B36";
      background-transparency-percent = 30;
      badge-color-set = false;
      bold-color-set = false;
      cursor-blink-mode = "off";
      cursor-colors-set = false;
      cursor-shape = "block";
      dim-transparency-percent = 10;
      font = lib.mkDefault "Monospace 13";
      foreground-color = "#93a1a1";
      highlight-colors-set = false;
      palette = [ "#002b36" "#dc322f" "#859900" "#b58900" "#268bd2" "#6c71c4" "#2aa198" "#93a1a1" "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#6c71c4" "#2aa198" "#fdf6e3" ];
      scrollback-unlimited = true;
      select-by-word-chars="-./?%&#_~";
      terminal-bell = "sound";
      terminal-title = "\${title}";
      use-system-font = false;
      use-theme-colors = false;
      visible-name = "Default";
    };
  };
}

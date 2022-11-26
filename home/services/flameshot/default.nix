{ lib, ... }:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        checkForUpdates = false;
        disabledTrayIcon = true;
        showHelp = false;
        showStartupLaunchMessage = false;
      };
    };
  };

  xdg.configFile."i3/config" = {
    text = ''
      bindsym Shift+Print exec --no-startup-id flameshot gui
    '';
  };
}

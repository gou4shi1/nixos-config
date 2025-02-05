{ ... }:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showHelp = false;
        showStartupLaunchMessage = false;
      };
    };
  };

  xfconf.settings.xfce4-keyboard-shortcuts."commands/custom/<Shift>Print" = "flameshot gui";
}

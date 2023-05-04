{ lib, ... }:

{
  xfconf.settings.xfce4-session = {
    "general/AutoSave" = true;
    "general/PromptOnLogout" = true;
    "compat/LaunchGNOME" = true;
    "shutdown/LockScreen" = false;
  };
}

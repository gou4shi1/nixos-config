{ machineType, ... }:

let
  workstationConf = {
    "xfce4-power-manager/battery-button-action" = 3;
    "xfce4-power-manager/blank-on-ac" = 10;
    "xfce4-power-manager/dpms-on-ac-off" = 20;
    "xfce4-power-manager/dpms-on-ac-sleep" = 15;
    "xfce4-power-manager/hibernate-button-action" = 3;
    "xfce4-power-manager/inactivity-on-ac" = 14;
    "xfce4-power-manager/power-button-action" = 3;
    "xfce4-power-manager/sleep-button-action" = 3;
  };
  laptopConf = {
    "xfce4-power-manager/battery-button-action" = 3;
    "xfce4-power-manager/blank-on-battery" = 5;
    "xfce4-power-manager/brightness-on-ac" = 120;
    "xfce4-power-manager/brightness-on-battery" = 120;
    "xfce4-power-manager/critical-power-action" = 3;
    "xfce4-power-manager/critical-power-level" = 5;
    "xfce4-power-manager/dpms-on-ac-off" = 20;
    "xfce4-power-manager/dpms-on-ac-sleep" = 15;
    "xfce4-power-manager/dpms-on-battery-off" = 15;
    "xfce4-power-manager/dpms-on-battery-sleep" = 10;
    "xfce4-power-manager/general-notification" = true;
    "xfce4-power-manager/handle-brightness-keys" = true;
    "xfce4-power-manager/hibernate-button-action" = 3;
    "xfce4-power-manager/inactivity-on-ac" = 60;
    "xfce4-power-manager/inactivity-on-battery" = 30;
    "xfce4-power-manager/inactivity-sleep-mode-on-battery" = 1;
    "xfce4-power-manager/power-button-action" = 3;
    "xfce4-power-manager/show-tray-icon" = true;
    "xfce4-power-manager/sleep-button-action" = 3;
  };

in
{
  xfconf.settings.xfce4-power-manager = (builtins.getAttr machineType {
    workstation = workstationConf;
    laptop = laptopConf;
  });

  dconf.settings = {
    "apps/light-locker" = {
      # If late-locking is true, light-locker will lock the session when the screensaver is deactivated.
      # If it's false, light-locker will lock the session when the screensaver is activated.
      late-locking = false;
    };
  };
}

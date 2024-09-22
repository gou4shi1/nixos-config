{ lib, machineType, ... }:

let
  workstationConf = {
    "xfce4-power-manager/battery-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/blank-on-ac" = 10;
    "xfce4-power-manager/dpms-on-ac-off" = { type = "uint"; value = 20; };
    "xfce4-power-manager/dpms-on-ac-sleep" = { type = "uint"; value = 15; };
    "xfce4-power-manager/hibernate-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/inactivity-on-ac" = { type = "uint"; value = 14; };
    "xfce4-power-manager/lock-screen-suspend-hibernate" = false;
    "xfce4-power-manager/power-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/sleep-button-action" = { type = "uint"; value = 3; };
  };
  laptopConf = {
    "xfce4-power-manager/battery-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/blank-on-ac" = 0;
    "xfce4-power-manager/blank-on-battery" = 0;
    "xfce4-power-manager/brightness-on-ac" = { type = "uint"; value = 120; };
    "xfce4-power-manager/brightness-on-battery" = { type = "uint"; value = 120; };
    "xfce4-power-manager/critical-power-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/critical-power-level" = { type = "uint"; value = 5; };
    "xfce4-power-manager/dpms-on-ac-off" = { type = "uint"; value = 20; };
    "xfce4-power-manager/dpms-on-ac-sleep" = { type = "uint"; value = 10; };
    "xfce4-power-manager/dpms-on-battery-off" = { type = "uint"; value = 15; };
    "xfce4-power-manager/dpms-on-battery-sleep" = { type = "uint"; value = 5; };
    "xfce4-power-manager/general-notification" = true;
    "xfce4-power-manager/handle-brightness-keys" = true;
    "xfce4-power-manager/hibernate-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/inactivity-on-ac" = { type = "uint"; value = 60; };
    "xfce4-power-manager/inactivity-on-battery" = { type = "uint"; value = 30; };
    "xfce4-power-manager/inactivity-sleep-mode-on-battery" = { type = "uint"; value = 1; };
    "xfce4-power-manager/lock-screen-suspend-hibernate" = false;
    "xfce4-power-manager/power-button-action" = { type = "uint"; value = 3; };
    "xfce4-power-manager/show-tray-icon" = true;
    "xfce4-power-manager/sleep-button-action" = { type = "uint"; value = 3; };
  };

in
{
  xfconf.settings = {
    xfce4-power-manager = (builtins.getAttr machineType {
      workstation = workstationConf;
      laptop = laptopConf;
    });
    xfce4-screensaver = {
      "saver/idle-activation/enabled" = true;
      "saver/idle-activation/delay" = 66;
      "screensavers/xfce-blank/dpms-off-after" = 0.0;
      "screensavers/xfce-blank/dpms-sleep-after" = 0.0;
    };
  };
}

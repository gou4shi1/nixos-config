{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.desktop;

in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # light-locker is a simple locker (forked from gnome-screensaver) that aims to have simple, sane, secure defaults
      # and be well integrated with the desktop while not carrying any desktop-specific dependencies.
      # It relies on lightdm for locking and unlocking your session via UPower or logind/systemd.
      # By default, it will lock on lid-closed, screensaver-deactivated (screen blank) and sleep.
      lightlocker
    ];

    environment.sessionVariables = with pkgs; {
      # Export the gsettings-schemas of light-locker, so that xfce4-power-manager-settings can config light-locker.
      XDG_DATA_DIRS = [ "${lightlocker}/share/gsettings-schemas/${lightlocker.name}" ];
    };

    # Allow xfce4-power-manager to suspend the system after lock.
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" && subject.isInGroup("users")) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}

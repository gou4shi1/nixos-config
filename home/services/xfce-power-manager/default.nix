{ lib, enableDesktop, machineType, ... }:

{
  config = lib.mkIf enableDesktop {
    xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml".source = (builtins.getAttr machineType {
      workstation = ./workstation-conf.xml;
      laptop = ./laptop-conf.xml;
    });

    dconf.settings = {
      "apps/light-locker" = {
        # If late-locking is true, light-locker will lock the session when the screensaver is deactivated.
        # If it's false, light-locker will lock the session when the screensaver is activated,
        # then xfce4-power-manager will have no authorization to suspend the system after timeout.
        late-locking = (machineType == "laptop");
      };
    };
  };
}

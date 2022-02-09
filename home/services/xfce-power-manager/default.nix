{ lib, enableDesktop, machineType, ... }:

{
  config = lib.mkIf enableDesktop {
    xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml".source = (builtins.getAttr machineType {
      workstation = ./workstation-conf.xml;
      laptop = ./laptop-conf.xml;
    });
  };
}

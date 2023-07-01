{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    corplink
  ];

  systemd.packages = with pkgs; [
    corplink
  ];

  systemd.services.corplink = {
    wantedBy = [ "multi-user.target" ];
    path = [ "/run/current-system/sw" ];
  };
}

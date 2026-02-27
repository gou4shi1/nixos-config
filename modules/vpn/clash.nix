{ config, lib, pkgs, ... }:

{
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    serviceMode = true;
    tunMode = true;
  };

  networking.firewall.trustedInterfaces = [ "Mihomo" ];
  networking.firewall.checkReversePath = false;  # Allow asymmetric routing for TUN
}

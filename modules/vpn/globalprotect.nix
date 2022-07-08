{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;

in {
  # This only enable the gpservice.
  services.globalprotect = {
    enable = true;
    csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

  # This also enable the gpclient.
  systemd.user.services = {
    gpclient = {
      description = "A GlobalProtect VPN client (GUI) for Linux, based on OpenConnect and built with Qt5, supports SAML auth mode.";
      enable = true;
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.globalprotect-openconnect}/bin/gpclient";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}

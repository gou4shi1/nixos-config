{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;

in {
  environment.systemPackages = with pkgs; [
    seal
  ];

  networking.networkmanager.dns = "dnsmasq";

  systemd.services = {
    seal-service = {
      description = "The daemon service of seal.";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ "/run/current-system/sw" ];
      serviceConfig = {
        Type = "simple";
        # You need to run `mkdir /opt/Seal` by yourself.
        WorkingDirectory = "/opt/Seal";
        # seal-service need to be run as /opt/Seal/seal-service...
        ExecStartPre = "${pkgs.coreutils}/bin/ln -sf ${pkgs.seal}/bin/seal-service /opt/Seal/seal-service";
        ExecStart = "/opt/Seal/seal-service";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}

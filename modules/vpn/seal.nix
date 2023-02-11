{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;

in {
  environment.systemPackages = with pkgs; [
    seal
  ];

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
        # bash need to be run as /bin/bash
        # seal-service need to be run as /opt/Seal/seal-service...
        # dnsmasq need to be run as /usr/sbin/dnsmasq ... --conf-dir=/etc/NetworkManager/dnsmasq.d
        ExecStartPre = "${pkgs.bash}/bin/bash -c 'ln -sf /bin/sh /bin/bash && ln -sf ${pkgs.seal}/bin/seal-service /opt/Seal/seal-service && mkdir -p /usr/sbin && ln -sf ${pkgs.dnsmasq}/bin/dnsmasq /usr/sbin/dnsmasq && mkdir -p /etc/NetworkManager/dnsmasq.d'";
        ExecStart = "/opt/Seal/seal-service";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}

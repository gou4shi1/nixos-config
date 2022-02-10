{ config, pkgs, ... }:

{
  systemd.services = {
    kill-all-docker-containers-before-shutdown = {
      description = "Kill all docker containers to prevent shutdown lag.";
      enable = true;
      wantedBy = [ "docker.service" ];
      after = [ "docker.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = pkgs.writeScript "docker-kill-all" ''
          #! ${pkgs.runtimeShell} -e
          ${pkgs.docker}/bin/docker ps --format '{{.ID}}' | xargs ${pkgs.docker}/bin/docker kill
        '';
      };
    };
  };
}

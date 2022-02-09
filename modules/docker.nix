{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
  usingNvidiaDriver = builtins.elem "nvidia" config.services.xserver.videoDrivers;

in {
  # docker.enableNvidia need this
  hardware.opengl.driSupport32Bit = usingNvidiaDriver;

  virtualisation.docker = {
    enable = true;
    enableNvidia = usingNvidiaDriver;
  };

  users.users."${cfg.mainUser}".extraGroups = [ "docker" ];

  # Fix "container error: cgroup subsystem devices not found"
  systemd.enableUnifiedCgroupHierarchy = !usingNvidiaDriver;
}

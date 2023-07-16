{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
  usingNvidiaDriver = builtins.elem "nvidia" config.services.xserver.videoDrivers;

in {
  imports = [
    # Temp fix docker+cifs hangs on shutdown.
    # ./kill-all-docker-containers-before-shutdown.nix
  ];

  virtualisation.docker = {
    enable = true;
    enableNvidia = usingNvidiaDriver;
  };

  virtualisation.podman = {
    enable = true;
    enableNvidia = usingNvidiaDriver;
    # Create an alias mapping docker to podman.
    # dockerCompat = true;
  };

  users.users."${cfg.mainUser}".extraGroups = [ "docker" ];

  # docker.enableNvidia need this
  hardware.opengl.driSupport32Bit = usingNvidiaDriver;
}

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
  };

  virtualisation.podman = {
    enable = true;
    # Create an alias mapping docker to podman.
    # dockerCompat = true;
  };

  users.users."${cfg.mainUser}".extraGroups = [ "docker" ];

  hardware.nvidia-container-toolkit.enable = usingNvidiaDriver;
}

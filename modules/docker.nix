{ config, lib, pkgs, ... }:

let
  usingNvidiaDriver = builtins.elem "nvidia" config.services.xserver.videoDrivers;

in {
  # docker.enableNvidia need this
  hardware.opengl.driSupport32Bit = usingNvidiaDriver;

  virtualisation.docker = {
    enable = true;
    enableNvidia = usingNvidiaDriver;
  };
}

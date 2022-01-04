{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ../../overlays)
  ];
}

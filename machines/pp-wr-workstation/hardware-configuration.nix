# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "7b0845d8c1376de700264886c9a002099c71736d";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/ssd"
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/nvidia.nix"
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.nvidia.prime.offload.enable = false;
  hardware.video.hidpi.enable = true;

  networking.interfaces.eno1.useDHCP = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS-ROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS-BOOT";
    fsType = "vfat";
  };

  fileSystems."/media/ubuntu" = {
    device = "/dev/disk/by-label/UBUNTU";
    fsType = "ext4";
  };

  fileSystems."/media/local_6t" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
  };
}

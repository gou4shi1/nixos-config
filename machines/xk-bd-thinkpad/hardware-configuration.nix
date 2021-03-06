# It was generated by `nixos-generate-config`.
{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "7b0845d8c1376de700264886c9a002099c71736d";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/laptop"
    "${nixos-hardware}/common/pc/laptop/ssd"
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/intel.nix"
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  hardware.video.hidpi.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS-ROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8225-C8E1";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/LINUX-SWAP"; }
  ];

  powerManagement.cpuFreqGovernor = "powersave";
}

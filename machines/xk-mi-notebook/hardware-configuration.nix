# It was generated by `nixos-generate-config`.
{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "e1cbffcf3a8b243fd6be880854fcd0169cd4165e";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/laptop"
    "${nixos-hardware}/common/pc/laptop/ssd"
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/intel"
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  services.xserver.videoDrivers = [ "intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS-ROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS-BOOT";
    fsType = "vfat";
  };

  #fileSystems."/media/arch/home" = {
  #  device = "/dev/disk/by-uuid/85a8494a-1118-48b9-b18d-ee7a36d80c98";
  #};

  swapDevices = [
    { device = "/dev/disk/by-uuid/6b94e563-40ec-4d53-8ae9-5d9a0baaa02f"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

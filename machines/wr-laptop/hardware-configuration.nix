# It was generated by `nixos-generate-config`.
{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = config.mynix;
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "c54cf53e022b0b3c1d3b8207aa0f9b194c24f0cf";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/laptop/ssd"
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/nvidia"
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "acpi_osi=linux" "acpi_backlight=video" ];
  boot.extraModulePackages = [ pkgs.lenovo-legion-module ];

  hardware.nvidia = {
    dynamicBoost.enable = true;
    powerManagement.enable = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "550.107.02";
      sha256_64bit = "sha256-+XwcpN8wYCjYjHrtYx+oBhtVxXxMI02FO1ddjM5sAWg=";
      sha256_aarch64 = "sha256-mVEeFWHOFyhl3TGx1xy5EhnIS/nRMooQ3+LdyGe69TQ=";
      openSha256 = "sha256-Po+pASZdBaNDeu5h8sgYgP9YyFAm9ywf/8iyyAaLm+w=";
      settingsSha256 = "sha256-WFZhQZB6zL9d5MUChl2kCKQ1q9SgD0JlP4CMXEwp2jE=";
      persistencedSha256 = "sha256-Vz33gNYapQ4++hMqH3zBB4MyjxLxwasvLzUJsCcyY4k=";
    };
  };

  services.xserver.dpi = 120;

  specialisation = {
    clamshell.configuration = {
      system.nixos.tags = [ "clamshell" ];

      hardware.nvidia.prime = {
        offload.enable = lib.mkForce false;
        offload.enableOffloadCmd = lib.mkForce false;
        sync.enable = lib.mkForce true;
      };

      services.upower.ignoreLid = true;
      services.logind.lidSwitchExternalPower = "ignore";

      services.xserver = {
        dpi = lib.mkForce 96;
        desktopManager.wallpaper.mode = lib.mkForce "tile";
      };

      home-manager.users."${cfg.mainUser}" = {
        programs.kitty.font.size = lib.mkForce 13;
      };

      systemd.user.services.gpclient.enable = lib.mkForce false;
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a2e375fe-4c80-4431-adbc-51f4d2c54586";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3186-A521";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}

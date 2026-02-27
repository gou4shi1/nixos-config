{ config, pkgs, ... }:

let
  cfg = config.mynix;

in
{
  imports = [
    ../base
    ../../modules/vpn/clash.nix
    ./hardware-configuration.nix
    ./home.nix
  ];

  mynix = {
    machineType = "laptop";
    mainUser = "aria";
  };

  nix.settings = {
    substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Shanghai";

  networking.hostName = "xk-thinkpad";
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.xserver = {
    # The custom wallpaper can not be placed in $HOME.
    displayManager.lightdm.background = "/opt/wallpaper.jpg";
  };

  services.openssh.enable = true;

  # Enable FingerPrint.
  # services.fprintd.enable = true;
  # security.pam.services.login.fprintAuth = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}

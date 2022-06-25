{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  imports = [
    ../base
    ./hardware-configuration.nix
    ./home.nix
  ];

  mynix = {
    machineType = "workstation";
    mainUser = "guangqing";
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    version = 2;
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = false;
    useOSProber = true;
    device = "nodev";
  };

  time.timeZone = "Asia/Shanghai";
  environment.etc."timezone".text = "${config.time.timeZone}\n";

  networking.hostName = "cgq-wr-workstation";
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   openconnect
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Use chrony to synchronise time.
  services.chrony.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

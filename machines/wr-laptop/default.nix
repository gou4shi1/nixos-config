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
    machineType = "laptop";
    mainUser = "guangqing";
  };

  nix.settings = {
    substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Shanghai";

  networking.hostName = "cgq-wr-laptop";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };

  services.xserver = {
    # The custom wallpaper can not be placed in $HOME.
    displayManager.lightdm.background = "/opt/wallpaper.jpg";
  };

  programs.steam.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}

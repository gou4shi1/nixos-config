{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  imports = [
    ../base
    ../base/bd.nix
    ./hardware-configuration.nix
    ./home.nix
    ./sensitive.nix
  ];

  mynix = {
    machineType = "laptop";
    mainUser = "aria";
  };

  nix.settings = {
    substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Shanghai";

  networking.hostName = "xk-bd-thinkpad";
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   openconnect
  # ];

  services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.xserver = {
    # The custom wallpaper can not be placed in $HOME.
    displayManager.lightdm.background = "/opt/wallpaper.jpg";
  };

  services.libinput.touchpad.naturalScrolling = true;

  # Enable FingerPrint.
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

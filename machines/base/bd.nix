{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
in
{
  imports = [
    ../../modules/vpn/corplink.nix
  ];

  # kerberos
  security.krb5 = {
    enable = true;
    settings = {
      libdefaults = {
        dns_canonicalize_hostname = false;
      };
    };
  };

  home-manager.users."${cfg.mainUser}" = {
    home.packages = with pkgs; [
      opensshWithKerberos
    ];
  };
}

{ config, lib, pkgs, ... }:

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
}

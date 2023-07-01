{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/vpn/corplink.nix
  ];

  # kerberos
  krb5 = {
    enable = true;
    libdefaults = {
      dns_canonicalize_hostname = false;
    };
  };
}

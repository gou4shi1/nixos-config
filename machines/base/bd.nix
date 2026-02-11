{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/vpn/corplink.nix
  ];

  nixpkgs = {
    overlays = [
      (import ../../overlays/bd.nix)
    ];
  };

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

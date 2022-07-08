{ config, lib, pkgs, ... }:

let

in {
  imports = [
    ../../modules/vpn/seal.nix
  ];

  nixpkgs = {
    overlays = [
      (import ../../overlays/bd.nix)
    ];
  };

  # kerberos
  krb5 = {
    enable = true;
    libdefaults = {
      dns_canonicalize_hostname = false;
    };
  };
}

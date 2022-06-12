final: prev:

let
  #backportPkgs = import (builtins.fetchTarball {
  #  # 2020 Jan 26
  #  url = https://github.com/NixOS/nixpkgs/tarball/05e661f665047984189b96c724f5a5a1745ec7cb;
  #}) { config.allowUnfree = true; };

  gvolpe-config = final.fetchFromGitHub {
    owner = "gvolpe";
    repo = "nix-config";
    rev = "a96d2824cb2531ee9239f1d3a065d05986f2af81";
    sha256 = "07cylmz94mw3wnl10m4wxlh49pkn8d4dz2drg3an0ybdsv2rp8ha";
  };

in {
  vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
  pack = final.callPackage ../pkgs/pack {};
  debian-hostname = final.callPackage ../pkgs/debian-hostname {};
  typora = final.callPackage ../pkgs/typora {};
  beauty-line-icon-theme = final.callPackage "${gvolpe-config}/home/themes/beauty-line" {};
  weggli = final.callPackage ../pkgs/weggli {};
  warpd = final.callPackage ../pkgs/warpd {};
  globalprotect-openconnect = final.libsForQt5.callPackage ../pkgs/globalprotect-openconnect {};
}

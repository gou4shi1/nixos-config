final: prev:

let
  #backportPkgs = import (builtins.fetchTarball {
  #  # 2020 Jan 26
  #  url = https://github.com/NixOS/nixpkgs/tarball/05e661f665047984189b96c724f5a5a1745ec7cb;
  #}) { config.allowUnfree = true; };

in {
  vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
}

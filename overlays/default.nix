final: prev:

let
  unstablePkgs = import
    (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/tarball/a63021a330d8d33d862a8e29924b42d73037dd37;
    })
    { config.allowUnfree = true; };

in {
  vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
  pack = final.callPackage ../pkgs/pack {};
  debian-hostname = final.callPackage ../pkgs/debian-hostname {};
  typora = final.callPackage ../pkgs/typora {};
  beauty-line-icon-theme = final.callPackage ../pkgs/beauty-line {};
  weggli = final.callPackage ../pkgs/weggli {};
  warpd = final.callPackage ../pkgs/warpd {};
  globalprotect-openconnect = final.libsForQt5.callPackage ../pkgs/globalprotect-openconnect {};
  feishu = final.callPackage ../pkgs/feishu {};
  coscli = final.callPackage ../pkgs/coscli {};
  clangd = final.callPackage ../pkgs/clangd {};
  vimHugeX = prev.vimHugeX.overrideAttrs (old: rec {
    version = "9.0.0626";
    src = prev.fetchFromGitHub {
      owner = "vim";
      repo = "vim";
      rev = "v${version}";
      hash = "sha256-mJ2fKXGEmW1aYUe9+Zx1OtVZFuIeit8f2PXPq/pRaI4=";
    };
  });
}

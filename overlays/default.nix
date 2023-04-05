final: prev:

let
  unstable = import <unstable> { config.allowUnfree = true; };

in {
  vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };
  feishu = unstable.feishu.override { commandLineArgs = "--disable-features=AudioServiceSandbox"; nss = prev.nss_latest; };
  globalprotect-openconnect = unstable.globalprotect-openconnect;
  warpd = unstable.warpd;
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
  pack = final.callPackage ../pkgs/pack {};
  debian-hostname = final.callPackage ../pkgs/debian-hostname {};
  typora = final.callPackage ../pkgs/typora {};
  weggli = final.callPackage ../pkgs/weggli {};
  nomachine = final.callPackage ../pkgs/nomachine {};
  coscli = final.callPackage ../pkgs/coscli {};
  clangd = final.callPackage ../pkgs/clangd {};
  xfconf-helper = final.callPackage ../pkgs/xfconf-helper {};

  lazygit = prev.lazygit.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "0af4e5a843f21bb2bc1caa6a24acf839df9c991a";
      hash = "sha256-wPvzTT58XEEIRmsOt0yFPnU9ZbCePQ0gQGv2QOH387M=";
    };
  });
}

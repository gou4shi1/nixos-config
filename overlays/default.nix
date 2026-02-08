final: prev:

{
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
  pack = final.callPackage ../pkgs/pack {};
  debian-hostname = final.callPackage ../pkgs/debian-hostname {};
  typora = final.callPackage ../pkgs/typora {};
  nomachine = final.callPackage ../pkgs/nomachine {};
  clangd = final.callPackage ../pkgs/clangd {};
  xfconf-helper = final.callPackage ../pkgs/xfconf-helper {};
  corplink = final.callPackage ../pkgs/corplink {};
  sync-clipboard = final.callPackage ../pkgs/sync-clipboard {};
  lenovo-legion-module = prev.linuxPackages.lenovo-legion-module.overrideAttrs (old: {
    patches = [ ../pkgs/lenovo-legion-module/y9000p2024.diff ];
  });
  auto-cpufreq = prev.auto-cpufreq.overrideAttrs (old: {
    patches = old.patches ++ [ ../pkgs/auto-cpufreq/fix-stats.diff ];
  });
}

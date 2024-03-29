final: prev:

let
  unstable = import <unstable> { config.allowUnfree = true; };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/fc4f9acb61749a12a7ff7ac4020142b121a5dd25.tar.gz") {
    nurpkgs = prev;
    pkgs = prev;
  };

in {
  vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };
  feishu = prev.feishu.overrideAttrs (old: rec {
    version = "6.9.16";
    packageHash = "fe01b99b";
    src = prev.fetchurl {
      url = "https://sf3-cn.feishucdn.com/obj/ee-appcenter/${packageHash}/Feishu-linux_x64-${version}.deb";
      hash = "sha256-+koH6/K0J8KCVaNGIVvmLmPn/Ttyc9WcNAp0f7PLkqg=";
    };
  });
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
  asm-lsp = unstable.asm-lsp;
  leetcode-cli = unstable.leetcode-cli;
  wechat-uos = nur.repos.xddxdd.wechat-uos;
}

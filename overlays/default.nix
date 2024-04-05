final: prev:

let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
  };

in {
  intel-vaapi-driver = prev.intel-vaapi-driver.override { enableHybridCodec = true; };
  rofi-power = final.callPackage ../pkgs/rofi-power {};
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria {};
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy {};
  pack = final.callPackage ../pkgs/pack {};
  debian-hostname = final.callPackage ../pkgs/debian-hostname {};
  typora = final.callPackage ../pkgs/typora {};
  nomachine = final.callPackage ../pkgs/nomachine {};
  clangd = final.callPackage ../pkgs/clangd {};
  xfconf-helper = final.callPackage ../pkgs/xfconf-helper {};
  wechat-uos = unstable.wechat-uos.override {
    uosLicense = ../pkgs/wechat-uos/license.tar.gz;
  };
}

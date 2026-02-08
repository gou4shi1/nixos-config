{ config, lib, pkgs, ... }:

let

in {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [ qt6Packages.fcitx5-chinese-addons ];
  };

  # The fcitx5-daemon service will be started before xfce, which breaks some fcitx features.
  # Moreover, fcitx will be started by xfce, so we can safely disable this service.
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  xdg.configFile."fcitx5/profile".source = lib.mkDefault ./profile;
  xdg.configFile."fcitx5/config".source = ./config;
  xdg.configFile."fcitx5/conf/classicui.conf".source = ./classicui.conf;
  xdg.configFile."fcitx5/conf/pinyin.conf".source = ./pinyin.conf;
  xdg.configFile."fcitx5/conf/cloudpinyin.conf".source = ./cloudpinyin.conf;
  xdg.configFile."fcitx5/conf/punctuation.conf".source = ./punctuation.conf;

  # Fcitx Themes that base on Material Design.
  xdg.dataFile."fcitx5/themes/Material-Color".source = pkgs.fetchFromGitHub {
    owner = "gou4shi1";
    repo = "Fcitx5-Material-Color";
    rev = "89481453e76ee40cd7c827be3913faf28eb20abf";
    sha256 = "15p5x8bikxc9r4w7ns2zck50n6npxkrx9p8xwgckahf86hajmgdy";
  };

  # Fcitx Pinyin Dictionary from zh.wikipedia.org.
  xdg.dataFile."fcitx5/pinyin/dictionaries/zhwiki.dict".source = builtins.fetchurl {
    url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.3.0/zhwiki-20251223.dict";
    sha256 = "0ip79radwmx5rrjhmp5g3kscl5xzidx3hsw0355vv8k1wiyqmwnp";
  };
}

{ config, lib, pkgs, ... }:

let

in {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
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
    url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20220529.dict";
    sha256 = "0riqzfm5m8xs83imil5628fbnkzz03dgpc056jx7yhgmhx09cmw7";
  };
}

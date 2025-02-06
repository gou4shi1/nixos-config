{ pkgs, dpi, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };
  };

  xfconf.settings.xsettings = {
    "Net/ThemeName" = "Juno";
    "Net/IconThemeName" = "BeautyLine";
    "Xft/DPI" = dpi;
  };
}

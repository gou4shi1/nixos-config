final: prev:

let

in {
  xfce = prev.xfce // {
    xfce4-settings = prev.xfce.xfce4-settings.overrideAttrs (old: rec {
      patches = old.patches or [ ] ++ [
        ../pkgs/xfce4-settings/hidpi.diff
      ];
    });
  };
}

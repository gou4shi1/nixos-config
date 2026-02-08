dpi: final: prev:

{
  xfce = prev.xfce // {
    xfce4-settings = prev.xfce.xfce4-settings.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [(prev.replaceVars ../pkgs/xfce4-settings/hidpi.diff {
        inherit dpi;
      })];
    });
  };
}

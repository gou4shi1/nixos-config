dpi: final: prev:

{
  xfce = prev.xfce // {
    xfce4-settings = prev.xfce.xfce4-settings.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [(prev.substituteAll {
        src = ../pkgs/xfce4-settings/hidpi.diff;
        inherit dpi;
      })];
    });
  };

  brave = prev.brave.override { commandLineArgs = "--force-device-scale-factor=2"; };
}

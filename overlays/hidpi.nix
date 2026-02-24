dpi: final: prev:

let
  scaleArg = "--force-device-scale-factor=${toString (dpi / 96)}";
in
{
  xfce = prev.xfce // {
    xfce4-settings = prev.xfce.xfce4-settings.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [
        (prev.replaceVars ../pkgs/xfce4-settings/hidpi.diff {
          inherit dpi;
        })
      ];
    });
  };
} // prev.lib.optionalAttrs (dpi >= 192) {
  google-chrome = prev.google-chrome.override { commandLineArgs = scaleArg; };
  brave = prev.brave.override { commandLineArgs = scaleArg; };
  feishu = prev.feishu.override { commandLineArgs = scaleArg; };
  qq = prev.qq.override { commandLineArgs = scaleArg; };
}

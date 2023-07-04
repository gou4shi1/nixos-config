{ config, lib, ... }:

let
  dpi = config.services.xserver.dpi;

in
{
  config = lib.mkIf (lib.isInt dpi && dpi > 96) {
    nixpkgs = {
      overlays = [
        (import ../../overlays/hidpi.nix dpi)
      ];
    };

    services.xserver.upscaleDefaultCursor = dpi >= 192;

    environment.variables = lib.mkIf (dpi >= 192) {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    };
  };
}

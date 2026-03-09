{ lib, config, pkgs, ... }:

let
  cfg = config.mynix;

  # Wrapper for uv that sets LD_LIBRARY_PATH for native packages
  uv-wrapped = pkgs.writeShellScriptBin "uv" ''
    export LD_LIBRARY_PATH="''${NIX_LD_LIBRARY_PATH:-/run/current-system/sw/share/nix-ld/lib}"
    exec ${pkgs.uv}/bin/uv "$@"
  '';

in
{
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/services/flameshot
      ../../home/programs/dev/python.nix
      ../../home/programs/dev/shell.nix
    ];

    home.packages = with pkgs; [
      clang
      python3
      uv-wrapped
      claude-code
      wechat-uos
    ];

    programs.git.settings.user = {
      name = "Guangqing Chen";
      email = "hi@goushi.me";
    };

    xfconf.settings = {
      xfce4-power-manager = {
        "xfce4-power-manager/inactivity-on-ac".value = lib.mkForce 0;
      };
    };
  };
}

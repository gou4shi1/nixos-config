{ lib, config, pkgs, ... }:

let
  cfg = config.mynix;
  nix-openclaw = builtins.fetchTarball {
    url = "https://github.com/openclaw/nix-openclaw/archive/6d6f93c17964a7a78ad5f6481fbac32a07e8ff74.tar.gz";
    sha256 = "0swxah59581a512i99sbv1g0mnw5fxf2brz0i0kx3ypppm2k4pqf";
  };

in
{
  nixpkgs.overlays = [ (import "${nix-openclaw}/nix/overlay.nix") ];

  home-manager.users."${cfg.mainUser}" = {
    systemd.user.services.openclaw-gateway = {
      Unit = {
        Description = "OpenClaw gateway";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        ExecStart = "${pkgs.openclaw}/bin/openclaw gateway";
        Restart = "always";
        RestartSec = "3s";
        Environment = [
          "HOME=/home/${cfg.mainUser}"
          "OPENCLAW_STATE_DIR=/home/${cfg.mainUser}/.openclaw"
          "OPENCLAW_CONFIG_PATH=/home/${cfg.mainUser}/.openclaw/openclaw.json"
          "OPENCLAW_NIX_MODE=0"
          "DISPLAY=:0"
          "XAUTHORITY=/home/${cfg.mainUser}/.Xauthority"
          "PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright.browsers}"
        ];
      };
    };
  };
}

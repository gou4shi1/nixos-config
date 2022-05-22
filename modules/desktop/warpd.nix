{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.desktop;

in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      warpd
    ];

    environment.etc."warpd/config" = {
      text = ''
        hint_activation_key: C-M-h
        grid_activation_key: C-M-g
        screen_activation_key: C-M-s
        activation_key: C-M-n
        hint_oneshot_key: C-M-o
      '';
    };

    systemd.user.services = {
      warpd = {
        description = "A modal keyboard driven pointer manipulation program.";
        enable = true;
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.warpd}/bin/warpd -f -c /etc/warpd/config";
        };
      };
    };
  };
}

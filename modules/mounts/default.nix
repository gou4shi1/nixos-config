{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.mounts;

in {
  options.mynix.mounts = with lib; {
    nasDevices = lib.mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          source = lib.mkOption {
            type = types.str;
            description = "The endpoint to connect to the nas device. e.g. //<ip>/<path>";
          };

          fsType = lib.mkOption {
            type = types.enum [ "cifs" ];
            default = "cifs";
            description = "The filesystem type, such as cifs (samba)";
          };

          credentials = lib.mkOption {
            type = types.str;
            description = "The samba credentials that contains username/password.";
          };
        };
      });

      default = { };
    };
  };

  config = {
    # Mount NAS
    fileSystems = lib.mapAttrs
      (target: deviceCfg: {
        device = deviceCfg.source;
        fsType = deviceCfg.fsType;
        options =
          let
            # This line prevents hanging on network split.
            automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
            iocharset_opts = "iocharset=utf8";
            uid_opts = "uid=1000,gid=100";
          in
          [ "${automount_opts},credentials=${deviceCfg.credentials},${iocharset_opts},${uid_opts}" ];
      })
      cfg.nasDevices;
  };
}

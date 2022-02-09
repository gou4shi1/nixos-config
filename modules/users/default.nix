{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;

in {
  options.mynix = with lib; {
    mainUser = mkOption {
      type = types.str;
      example = "guangqing";
      description = "The main user name with uid = 1000";
    };
  };

  config = {
    users = {
      users = {
        "${cfg.mainUser}" = {
          isNormalUser = true;
          uid = 1000;
          extraGroups = [
            "wheel" # enable `sudo`
            "networkmanager"
          ];
          shell = pkgs.zsh;
          # Don't forget to set your own password with `passwd`.
          initialPassword = "123456";
        };
      };
    };

    security.sudo.extraRules = [
      {
        users = [ "${cfg.mainUser}" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}

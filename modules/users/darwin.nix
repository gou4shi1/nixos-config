{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;

in {
  options.mynix = with lib; {
    mainUser = mkOption {
      type = types.str;
      example = "xk";
      description = "The main user name of your macOS.";
    };
  };

  config = {
    users = {
      users = {
        "${cfg.mainUser}" = {
          name = "${cfg.mainUser}";
          home = "/Users/${cfg.mainUser}";
        };
      };
    };
  };
}

{ config, lib, pkgs, ... } :

let
  cfg = config.mynix;

in {
  options.mynix = with lib; {
    machineType = mkOption {
      type = types.enum [ "workstation" "laptop" "server" ];
      default = "workstation";
      description = ''
        Specify the type of the machine.
        Based on the value, default settings can adjust automatically.
      '';
    };
  };

  config = {
    mynix.desktop = {
      enable = lib.mkDefault (builtins.getAttr cfg.machineType {
        workstation = true;
        laptop = true;
        server = false;
      });
      xserver.i3_show_battery = cfg.machineType == "laptop";
    };
  };
}

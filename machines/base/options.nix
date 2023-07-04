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
    mynix.desktop = with lib; {
      enable = mkDefault (builtins.getAttr cfg.machineType {
        workstation = true;
        laptop = true;
        server = false;
      });
      xserver = {
        replace_caps_with_ctrl = lib.mkDefault (cfg.machineType == "laptop");
        i3_show_battery = (cfg.machineType == "laptop");
      };
    };
  };
}

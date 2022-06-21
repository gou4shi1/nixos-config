{ config, pkgs, ... }:

let
  cfg = config.mynix;

in {
  home-manager.users."${cfg.mainUser}" = {
    imports = [
      ../../home/programs/dev/bazel.nix
      ../../home/programs/dev/cpp.nix
      ../../home/programs/dev/js.nix
    ];

    home.packages = with pkgs; [
      debian-hostname zoom-us arcanist
    ];

    home.sessionVariables = {
      JC_CAR_ID = "GZU_SPY_10036";
    };

    programs.zsh.initExtra = ''
      source ~/temp/gde.sh no_extra_opt_jc /run/user/1000 /etc/fonts
    '';

    programs.git = {
      userName = "guangqing.chen";
      userEmail = "guangqing.chen@weride.ai";
    };
  };
}

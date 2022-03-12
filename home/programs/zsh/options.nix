{ config, lib, pkgs, ... }:

let

in {
  options.mynix.zsh = with lib; {
    prompt_style = mkOption {
      type = types.enum [ "rainbow" "lean" ];
      default = "rainbow";
      description = ''
        Specify the style of zsh prompt.
      '';
    };
  };
}

{ pkgs }:

pkgs.writeScriptBin "rofi-power" (builtins.readFile ./rofi-power.sh)

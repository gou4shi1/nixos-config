{ pkgs }:

pkgs.writeScriptBin "i3-get-window-criteria" (builtins.readFile ./i3-get-window-criteria.sh)

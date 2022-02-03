{ config, lib, pkgs, ... }:

let

in {
  xdg.configFile."i3-resurrect/config.json".source = ./i3-resurrect-config.json;
}

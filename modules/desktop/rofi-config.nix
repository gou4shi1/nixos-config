{ config, lib, pkgs, ... }:

let

in {
  environment.etc."i3/rofi-solarized.rasi" = {
    text = ''
      @theme "solarized_alternate"
      window {
        border: 3;
        border-radius: 10px;
        border-color: rgb(130, 140, 150);
        transparency: "screenshot";
      }
    '';
  };
}

{ pkgs, writeShellApplication }:

writeShellApplication {
  name = "i3-get-window-criteria";

  runtimeInputs = with pkgs; [
    xwininfo
    xprop
  ];

  text = (builtins.readFile ./i3-get-window-criteria.sh);

  # To disable the shellcheck.
  checkPhase = "";
}

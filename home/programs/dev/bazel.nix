{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    bazel
    bazel-buildtools
  ];
}

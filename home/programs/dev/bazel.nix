{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    bazel_4
    bazel-buildtools
  ];
}

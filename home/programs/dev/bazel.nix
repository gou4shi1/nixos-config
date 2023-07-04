{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bazel
    bazel-buildtools
  ];
}

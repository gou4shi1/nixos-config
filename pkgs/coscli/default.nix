{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "coscli";
  version = "0.13.0-beta";

  src = fetchurl {
    url = "https://github.com/tencentyun/coscli/releases/download/v${version}/coscli-linux";
    hash = "sha256-6o8CbDy9Iqz5z0mysh5u4/txLFHzIGJ38CIO3FawF3w=";
  };

  unpackCmd = ''
    mkdir out
    cp $curSrc out/coscli
  '';

  installPhase = ''
    install -m755 -D coscli $out/bin/coscli
  '';

  meta = with lib; {
    description = "The CLI of Tencent Cloud COS.";
  };
}

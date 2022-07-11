{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "coscli";
  version = "0.11.0-beta";

  src = fetchurl {
    url = "https://github.com/tencentyun/coscli/releases/download/v${version}/coscli-linux";
    sha256 = "sha256-VyYH5BGDpTJ9Aby4WUyb4T4zanj8Uz2+ua5UW4TtGac=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

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

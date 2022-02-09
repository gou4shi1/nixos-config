{ lib, stdenv, fetchurl, autoPatchelfHook, dpkg }:

stdenv.mkDerivation rec {
  pname = "debian-hostname";
  version = "3.23";

  src = fetchurl {
    url = "http://ftp.cn.debian.org/debian/pool/main/h/hostname/hostname_${version}_amd64.deb";
    sha256 = "14d7xj48k3bqsc5js0129ygqhan3rxmnwzxr6hd7pvjg69vcv21j";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  unpackCmd = "dpkg -x $curSrc source";

  installPhase = ''
    mkdir -p $out
    mv bin usr $out/
  '';

  meta = with lib; {
    description = "The debian version hostname which support more options.";
  };
}

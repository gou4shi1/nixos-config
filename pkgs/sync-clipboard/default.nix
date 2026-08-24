{ lib, stdenv, fetchurl, autoPatchelfHook, makeWrapper, dpkg, gcc, zlib, fontconfig, lttng-ust_2_12, icu, openssl, libXt, libXtst, libXinerama, libX11, libICE, libSM }:

stdenv.mkDerivation rec {
  pname = "sync-clipboard";
  version = "2.9.0";

  src = fetchurl {
    url = "https://github.com/Jeric-X/SyncClipboard/releases/download/v${version}/syncclipboard_${version}_linux_self-contained_amd64.deb";
    hash = "sha256-WgXbRtRbXovyPkFQbwtfTzQdSpIf1jrfc+2krn/sxR0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    dpkg
  ];

  buildInputs = [
    gcc
    zlib
    fontconfig
    lttng-ust_2_12
    libXt
    libXtst
    libXinerama
  ];

  unpackCmd = "dpkg -x $curSrc source";

  installPhase = ''
    mkdir -p $out/bin
    mv opt usr $out/
    ln -s $out/opt/xyz.jericx.desktop.syncclipboard/SyncClipboard.Desktop.Default $out/bin/SyncClipboard
    sed -i "s|/opt/xyz.jericx.desktop.syncclipboard/SyncClipboard.Desktop.Default|$out/bin/SyncClipboard|" $out/usr/share/applications/xyz.jericx.desktop.syncclipboard.desktop 
    wrapProgram $out/bin/SyncClipboard \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ icu openssl libX11 libICE libSM ]}
  '';

  meta = with lib; {
    description = "Cross-Platform Clipboard Syncing Solution";
  };
}

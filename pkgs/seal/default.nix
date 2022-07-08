{ lib, stdenv, autoPatchelfHook, makeWrapper,
  xorg, gtk3, nss, nspr, alsa-lib, electron_9 }:

stdenv.mkDerivation rec {
  pname = "seal";
  version = "0.2.8";

  src = ./seal-0.2.8.35-amd64.tar.gz;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with xorg; [
    libXi
    libXfixes
    libXtst
    libX11
    libXext
    libXdamage
    libXScrnSaver
    gtk3
    nss
    nspr
    alsa-lib
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv opt $out

    ln -s $out/opt/Seal/Seal $out/bin/Seal
    # seal-service require FHS, temp need `sudo ln -s /run/current-system/sw/bin/bash /bin/bash`
    ln -s $out/opt/Seal/seal-service $out/bin/seal-service

    substituteInPlace $out/opt/Seal/Seal \
      --replace /opt/Seal/seal $out/opt/Seal/seal;

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron_9}/bin/electron $out/opt/Seal/seal \
      --add-flags $out/opt/Seal/resources/app.asar
  '';

  meta = with lib; {
    description = "The Network Manager of BD.";
  };
}

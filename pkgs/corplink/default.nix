{ pkgs
, lib
, stdenv
, fetchurl
, autoPatchelfHook
, buildFHSUserEnvBubblewrap
, makeDesktopItem
}:

let
  version = "2.1.10";

  src = fetchurl {
    url = "https://oss-s3.ifeilian.com/linux/FeiLian_Linux_amd64_v${version}_r2056_3880ba.tar.gz";
    hash = "sha256-fq0N6pbNygApr9aliUBj7fBLBoe7duXYQaNGtUL/w3U=";
  };

  corplink-wrapped = stdenv.mkDerivation {
    pname = "corplink-wrapped";
    inherit version;
    inherit src;

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    buildInputs = with pkgs; [
      alsa-lib
      glib
      gnome2.pango
      gtk3
      libdrm
      mesa.drivers
      nss
    ];

    installPhase = ''
      mkdir -p $out/bin
      mv opt $out
      ln -s $out/opt/Corplink/bin/* $out/bin/
      ln -s $out/opt/Corplink/corplink-service $out/bin/corplink-service
    '';
  };

  corplink-fhs-env = buildFHSUserEnvBubblewrap {
    name = "corplink-fhs-env";

    targetPkgs = pkgs: with pkgs; [
      xorg.libX11
      xorg.libXext
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXcomposite
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
      libglvnd
      mesa
      mesa.drivers
      alsa-lib
      glib
      nss
      libxkbcommon
      libdrm
      cairo
      gtk3
      pulseaudio
      pciutils
      libva
      udev
      xdg-utils
      nspr
      atk
      cups
      dbus
      gnome2.pango
      gdk-pixbuf
      expat
      at-spi2-atk
      at-spi2-core
    ];

    extraBwrapArgs = [
      "--bind /opt/Corplink /opt/Corplink"
    ];
  };

  desktopItem = makeDesktopItem {
    name = "Corplink";
    desktopName = "Corplink";
    genericName = "FeiLian";
    exec = "${corplink-fhs-env}/bin/corplink-fhs-env -c /opt/Corplink/corplink --no-sandbox";
  };

  createRunEnv = pkgs.writeShellScript "create-corplink-env.sh" ''
    if [ ! -d /opt/Corplink ] || [ "$(cat /opt/Corplink/version 2>/dev/null)" != "${version}" ]; then
      TEMP_DIR=$(mktemp -d)
      tar xzf ${src} -C "$TEMP_DIR" --strip-components=1
      rm -rf /opt/Corplink
      mv "$TEMP_DIR/opt/Corplink" /opt/
      echo "${version}" > /opt/Corplink/version
    fi
    ln -sf ${corplink-wrapped}/bin/corplink-service /opt/Corplink/corplink-service
    ln -sf ${corplink-wrapped}/bin/corplink-ow /opt/Corplink/bin/corplink-ow
    ln -sf ${corplink-wrapped}/bin/corplink-shield /opt/Corplink/bin/corplink-shield
    ln -sf /bin/sh /bin/bash
    mkdir -p /usr/sbin
    ln -sf ${pkgs.dnsmasq}/bin/dnsmasq /usr/sbin/dnsmasq
    mkdir -p /etc/NetworkManager/dnsmasq.d
  '';

  systemdService = pkgs.writeText "corplink.service" ''
    [Unit]
    Description=Corplink Service
    After=network.target
    [Service]
    Type=simple
    ExecStartPre=${createRunEnv}
    ExecStart=/opt/Corplink/corplink-service
    Restart=on-failure
    RestartSec=3s
  '';

in
stdenv.mkDerivation {
  pname = "corplink";
  inherit version;

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/share/applications
    ln -s ${desktopItem}/share/applications/* $out/share/applications/
    mkdir -p $out/lib/systemd/system
    cp ${systemdService} $out/lib/systemd/system/corplink.service
  '';
}

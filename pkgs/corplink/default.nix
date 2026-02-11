{ pkgs
, lib
, stdenv
, fetchurl
, autoPatchelfHook
, buildFHSEnvBubblewrap
, makeDesktopItem
, dpkg }:

let
  version = "3.1.12";

  src = fetchurl {
    url = "https://cdn.isealsuite.com/linux/FeiLian_Linux_amd64_v${version}_r5447_36661b.%7Bbytedance%7D.deb";
    hash = "sha256-qiqffcptYE+tr5aE2CoWvDHyMZ4lQFRs+Xq7RS6SgWo=";
  };

  corplink-wrapped = stdenv.mkDerivation {
    pname = "corplink-wrapped";
    inherit version src;
    nativeBuildInputs = [ autoPatchelfHook dpkg ];
    buildInputs = with pkgs; [
      alsa-lib
      glib
      pango
      gtk3
      libdrm
      mesa
      nss
      libxcrypt-legacy
      libhandy
      libcanberra
      libcanberra-gtk3
    ];

    installPhase = ''
      mkdir -p $out/bin
      mv opt $out
      ln -s $out/opt/apps/com.volcengine.feilian/files/bin/* $out/bin/
      ln -s $out/opt/apps/com.volcengine.feilian/files/corplink-service $out/bin/corplink-service
    '';
  };

  corplink-fhs-env = buildFHSEnvBubblewrap {
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
      libgbm
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
      pango
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
    name = "corplink";
    desktopName = "corplink";
    genericName = "corplink";
    terminal = false;
    mimeTypes = ["x-scheme-handler/corplink" "x-scheme-handler/feilian" "x-scheme-handler/seal"];
    exec = ''${corplink-fhs-env}/bin/corplink-fhs-env -c "/opt/apps/com.volcengine.feilian/files/corplink --no-sandbox %U"'';
  };

  createRunEnv = pkgs.writeShellScript "create-corplink-env.sh" ''
    if [ ! -d /opt/apps/com.volcengine.feilian ] || [ "$(cat /opt/apps/com.volcengine.feilian/version 2>/dev/null)" != "${version}" ]; then
      TEMP_DIR=$(mktemp -d)
      ${pkgs.dpkg}/bin/dpkg-deb -x ${src} "$TEMP_DIR"
      rm -rf /opt/apps/com.volcengine.feilian
      mkdir -p /opt/apps/com.volcengine.feilian
      mv "$TEMP_DIR/opt/apps/com.volcengine.feilian" /opt/apps/
      echo "${version}" > /opt/apps/com.volcengine.feilian/version
    fi
    ln -sf ${corplink-wrapped}/bin/corplink-service /opt/apps/com.volcengine.feilian/files/corplink-service
    ln -sf ${corplink-wrapped}/bin/corplink-security /opt/apps/com.volcengine.feilian/files/bin/corplink-security
    ln -sf ${corplink-wrapped}/bin/corplink-uc /opt/apps/com.volcengine.feilian/files/bin/corplink-uc
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
    ExecStart=/opt/apps/com.volcengine.feilian/files/corplink-service
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

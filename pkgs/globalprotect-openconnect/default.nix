{ stdenv, lib, fetchFromGitHub
, cmake, qtwebsockets, qtwebengine, wrapQtAppsHook, openconnect }:

stdenv.mkDerivation rec {
  pname = "globalprotect-openconnect";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "yuezk";
    repo = "GlobalProtect-openconnect";
    fetchSubmodules = true;
    rev = "v${version}";
    sha256 = "sha256-J4f+DJuKQUGK49muAtPU1aL/KI9mofIjyCcIztNVyr4=";
  };

  nativeBuildInputs = [ cmake wrapQtAppsHook ];

  buildInputs = [ openconnect qtwebsockets qtwebengine ];

  patchPhase = ''
    substituteInPlace GPService/gpservice.h \
      --replace /usr/local/bin/openconnect ${openconnect}/bin/openconnect;
    patch -p1 < ${./auto-complete.patch}
  '';

  meta = with lib; {
    description = "GlobalProtect VPN client (GUI) for Linux based on OpenConnect that supports SAML auth mode";
    homepage = "https://github.com/yuezk/GlobalProtect-openconnect";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}

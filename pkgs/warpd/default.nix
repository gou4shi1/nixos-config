{ stdenv, lib, fetchFromGitHub, xorg, ... }:

stdenv.mkDerivation rec {
  pname = "warpd";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "${pname}";
    # rev = "v${version}";
    rev = "a30bee8396932baef778ff45eba8ede4c6114b0a";
    sha256 = "1fzmc043zr1zv43qjh7raz9rb0n9a9j5izzzx0mzs8f28cm927i1";
  };

  buildInputs = with xorg; [
    libXi
    libXinerama
    libXft
    libXfixes
    libXtst
    libX11
    libXext
  ];

  installPhase = ''
    mkdir -p $out/{bin,share/man/man1}
    install -m644 warpd.1.gz $out/share/man/man1/
    install -m755 bin/warpd $out/bin/
  '';

  meta = with lib; {
    description = "A modal keyboard-driven virtual pointer.";
    homepage = "https://github.com/rvaiya/${pname}";
    license = licenses.mit;
  };
}

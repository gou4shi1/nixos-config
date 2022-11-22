{ lib
, stdenv
, fetchFromGitHub
, git
, libXi
, libXinerama
, libXft
, libXfixes
, libXtst
, libX11
, libXext
, waylandSupport ? false, cairo, libxkbcommon, wayland
}:

stdenv.mkDerivation rec {
  pname = "warpd";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "warpd";
    rev = "v${version}";
    sha256 = "sha256-5B3Ec+R1vF2iI0ennYcsRlnFXJkSns0jVbyAWJA4lTU=";
    leaveDotGit = true;
  };

  nativeBuildInputs = [ git ];

  buildInputs =  if waylandSupport then [
    cairo
    libxkbcommon
    wayland
  ] else [
    libXi
    libXinerama
    libXft
    libXfixes
    libXtst
    libX11
    libXext
  ];

  makeFlags = [ "PREFIX=$(out)" ] ++ lib.optionals (!waylandSupport) [ "DISABLE_WAYLAND=1" ];

  meta = with lib; {
    description = "A modal keyboard driven interface for mouse manipulation.";
    homepage = "https://github.com/rvaiya/warpd";
    changelog = "https://github.com/rvaiya/warpd/blob/${src.rev}/CHANGELOG.md";
    maintainers = with maintainers; [ hhydraa ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}

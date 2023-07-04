{ lib, stdenv, fetchFromGitHub, makeWrapper, pkgs }:

stdenv.mkDerivation {
  pname = "git-fuzzy";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "bigH";
    repo = "git-fuzzy";
    rev = "a9a030d18be0a01f576e6319f893938c75dfc868";
    hash = "sha256-Ni7D+rAClu/GevOJvt/k4OINyrEyUa8tXuqGJW1/HDw=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = with pkgs; ''
    install -vd $out
    cp -r bin lib $out
    wrapProgram $out/bin/git-fuzzy --prefix PATH : ${lib.makeBinPath [ bc ]}
  '';

  meta = {
    description = "Interactive `git` with the help of `fzf`.";
    homepage = "https://github.com/bigH/git-fuzzy";
    license = lib.licenses.mit;
  };
}

{ lib, stdenv, fetchFromGitHub, makeWrapper, pkgs }:

stdenv.mkDerivation {
  pname = "git-fuzzy";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "bigH";
    repo = "git-fuzzy";
    rev = "36fc08f084a0cabf3e381dbbbce8e3a1a22fbaa4";
    hash = "sha256-4VK7qSTROsFVnYuwTz+4sR/41iJjUzIxB2IcNE65Tm8=";
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

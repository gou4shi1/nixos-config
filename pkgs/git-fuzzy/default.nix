{ lib, stdenv, fetchFromGitHub, makeWrapper, pkgs }:

stdenv.mkDerivation {
  pname = "git-fuzzy";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "bigH";
    repo = "git-fuzzy";
    rev = "5e5ec3956dfc9b3b9593b77ad41f8267821149e6";
    hash = "sha256-yBdxEtF4Wmygs8JdY3m43iKsHm8Dp3hblT9VhZ+YpkM=";
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

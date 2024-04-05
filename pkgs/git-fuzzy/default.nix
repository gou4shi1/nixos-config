{ lib, stdenv, fetchFromGitHub, makeWrapper, pkgs }:

stdenv.mkDerivation {
  pname = "git-fuzzy";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "bigH";
    repo = "git-fuzzy";
    rev = "41b7691a837e23e36cec44e8ea2c071161727dfa";
    hash = "sha256-fexv5aesUakrgaz4HE9Nt954OoBEF06qZb6VSMvuZhw=";
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

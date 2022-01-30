{ lib, stdenv, fetchFromGitHub, makeWrapper, pkgs }:

let
  version = "0.0.1";

in stdenv.mkDerivation {
  pname = "git-fuzzy";
  inherit version;

  src = fetchFromGitHub {
    owner = "bigH";
    repo = "git-fuzzy";
    rev = "6bf6db61d3bd9a16203130587ccfbc02f4ca9a57";
    sha256 = "1iivvh1sbfw1h8klcwrhxs4g9cbifg0g2gp0fc8a16qy8dq45mzm";
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
    platforms = lib.platforms.all;
  };
}

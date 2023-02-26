{ stdenv, fetchFromGitHub, bundlerEnv }:

let
  version = "1.0";
  gems = bundlerEnv {
    name = "xfconf-helper-env";
    gemdir = ./.;
  };

in
stdenv.mkDerivation {
  name = "xfconf-helper";

  inherit version;
  src = fetchFromGitHub {
    owner = "felipec";
    repo = "xfce-config-helper";
    rev = "v${version}";
    hash = "sha256-tUane/MQTpyuDU0n4KlZwH3L1rFBonEBePWwKVwvyjM=";
  };

  buildInputs = [ gems gems.wrappedRuby ];
  installPhase = ''
    mkdir -p $out/{bin,share/xfconf-helper}
    cp defaults.yml $out/share/xfconf-helper
    cp dump $out/bin/xfconf-dump
    cp load $out/bin/xfconf-load
    substituteInPlace $out/bin/xfconf-dump --replace \'/usr\' \'$out\';
  '';
}

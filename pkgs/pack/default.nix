{ lib, stdenv, fetchFromGitHub, rustPlatform
, openssl, pkg-config, cmake, installShellFiles
, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "pack";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "maralla";
    repo = "pack";
    rev = "84f07738c0c6f74c1608235a98388cbcc5e9efea";
    sha256 = "0zdzy2blqvbdbxcvd4q70b5ldbn13nr7597p2fb0lvf3bb83qvwv";
  };

  cargoSha256 = "0awnfc0dlic76ysqnsnm0gpg582nhb80y82dqvj21sappc9xpn2w";

  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  nativeBuildInputs = [ pkg-config cmake installShellFiles ];

  postInstall = ''
    installShellCompletion contrib/pack.{bash,fish} --zsh contrib/_pack
  '';

  meta = with lib; {
    description = "The missing vim8 package manager. ";
  };
}

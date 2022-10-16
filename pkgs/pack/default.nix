{ lib, stdenv, fetchFromGitHub, rustPlatform
, openssl, pkg-config, cmake, installShellFiles
, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "pack";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "gou4shi1";
    repo = "pack";
    rev = "28c48a73ecfb7e5b80e32da52de21f4d767669bb";
    hash = "sha256-A8grXjYDbSyZjt8hGHBpndLg1bp4WG1SF1S4BQyP+kU=";
  };

  cargoHash = "sha256-01tvCAVNZEZgoj3J0GzkcDUvRwiEOEaZIIW/ZEVuiB8=";

  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  nativeBuildInputs = [ pkg-config cmake installShellFiles ];

  postInstall = ''
    installShellCompletion contrib/pack.{bash,fish} --zsh contrib/_pack
  '';

  meta = with lib; {
    description = "The missing vim8 package manager. ";
  };
}

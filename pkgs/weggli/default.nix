{ lib, fetchFromGitHub, rustPlatform
, openssl, pkg-config, cmake, installShellFiles }:

rustPlatform.buildRustPackage rec {
  pname = "weggli";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "weggli-rs";
    repo = "weggli";
    rev = "v${version}";
    hash = "sha256-6XSedsTUjcZzFXaNitsXlUBpxC6TYVMCB+AfH3x7c5E=";
  };

  cargoHash = "sha256-Cj/m4GRaqI/lHYFruj047B7FdGoVl/wC8I2o1dzhOTs=";

  meta = with lib; {
    description = "A fast and robust semantic search tool for C and C++ codebases.";
  };
}

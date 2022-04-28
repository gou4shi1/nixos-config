{ lib, fetchFromGitHub, rustPlatform
, openssl, pkg-config, cmake, installShellFiles }:

rustPlatform.buildRustPackage rec {
  pname = "weggli";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "googleprojectzero";
    repo = "weggli";
    rev = "e5ea3a293fce8fd17612f8d7c0f3220e5365827e";
    sha256 = "178qv0lghw2xmwq4cs83b0skrqkmpx4k34714x6vdr7ws636jxsl";
  };

  cargoSha256 = "1az7i88cbc9awppgc2pm7qvr3llniibni7rijb5scsdb8lzhp034";

  nativeBuildInputs = [ pkg-config cmake ];

  meta = with lib; {
    description = "A fast and robust semantic search tool for C and C++ codebases.";
  };
}

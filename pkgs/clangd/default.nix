{ pkgs, stdenv, fetchzip, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "clangd";
  version = "16.0.2";

  src = fetchzip {
    url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
    hash = "sha256-3NSBktpGnSsBSUvGyroFzgNiDWokik1sAliovRYk6tA=";
  };

  clang = pkgs.clang_16;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    grpc
    protobuf
  ];

  installPhase = ''
    mkdir $out
    cp -r bin lib $out

    mv $out/bin/{clangd,.clangd}
    substituteAll ${./wrapper} $out/bin/clangd
    chmod +x $out/bin/clangd
  '';

  meta = {
    description = "The language server from clang.";
    priority = -1; # To override the clangd from pkgs.clang-tools.
  };
}

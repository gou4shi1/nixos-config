{ lib, pkgs, stdenv, fetchzip, autoPatchelfHook, clang_14 }:

stdenv.mkDerivation rec {
  pname = "clangd";
  version = "14.0.3";

  src = fetchzip {
    url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
    hash = "sha256-TeIP6fGfx4kiVASqKPaAh3j2vtBGKuJ4kC8yHiLIs9U";
  };

  clang = clang_14;

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

  meta = with lib; {
    description = "The language server from clang.";
    priority = -1; # To override the clangd from pkgs.clang-tools.
  };
}

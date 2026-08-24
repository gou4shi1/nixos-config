{ pkgs, stdenv, fetchzip, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "clangd";
  version = "22.1.6";

  src = fetchzip {
    url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
    hash = "sha256-Jb1FkUdRDLlXCoXm0Zon0MyJaywzyFkH5ksdBS25pjE=";
  };

  clang = pkgs.clang_22;

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

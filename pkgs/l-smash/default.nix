{ lib, stdenv, fetchzip, nasm, which }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = import ./source.nix { inherit fetchzip; };
in
stdenv.mkDerivation rec {
  pname = "l-smash";
  inherit (source) version src;

  nativeBuildInputs = [ nasm which ];

  meta = with lib; {
    description = "L-SMASH MP4 library (core)";
    homepage = "https://github.com/l-smash/l-smash";
    license = licenses.isc;
    platforms = platforms.linux;
  };
}

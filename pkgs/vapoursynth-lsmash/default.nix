{ lib, stdenv, fetchzip, pkg-config, which, ffmpeg_4, vapoursynth, l-smash }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = import ./source.nix { inherit fetchzip; };
in
stdenv.mkDerivation rec {
  pname = "vapoursynth-lsmash";
  inherit (source) version src;

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ffmpeg_4 l-smash ];

  hardeningDisable = [ "all" ];

  postPatch = ''
    patchShebangs VapourSynth/configure
    export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error=implicit-function-declaration"
  '';

  configurePhase = ''
    runHook preConfigure
    cd VapourSynth
    ./configure --prefix=$out
    runHook postConfigure
  '';

  meta = with lib; {
    description = "L-SMASH Works VapourSynth plugin (lsmas)";
    homepage = "https://github.com/VFR-maniac/L-SMASH-Works";
    license = licenses.isc;
    platforms = platforms.linux;
  };
}

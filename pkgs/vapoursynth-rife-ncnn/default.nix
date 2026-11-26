{ lib, stdenv, autoPatchelfHook, fetchurl, p7zip, gcc-unwrapped, vulkan-loader }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = import ./source.nix { inherit fetchurl stdenv; };
in
stdenv.mkDerivation rec {
  pname = "vapoursynth-rife-ncnn";
  inherit (source) version src;

  # 预编译插件（ncnn+Vulkan 静态链接，仅依赖 libgomp/libstdc++，运行期 dlopen libvulkan）
  plugin = src;

  models = fetchurl {
    url = "https://github.com/cookieidea/vs-models/releases/download/rife-std-v1/rife-models.7z";
    hash = "sha256-Vdb6aZMI253BtAP/TH5NPvB05Weg/rP2FEl9IHjvWb8=";
  };

  nativeBuildInputs = [ autoPatchelfHook p7zip ];
  buildInputs = [ stdenv.cc.cc.lib gcc-unwrapped.lib vulkan-loader ];
  sourceRoot = ".";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    tmpdir=$(mktemp -d)
    mkdir -p $out/lib/vapoursynth
    cp ${plugin} $out/lib/vapoursynth/librife.so
    chmod +w $out/lib/vapoursynth/librife.so
    7z x -y ${models} -o$tmpdir >/dev/null
    mv $tmpdir/models $out/lib/vapoursynth/models
    runHook postInstall
  '';

  meta = with lib; {
    description = "RIFE VapourSynth plugin (ncnn + Vulkan; AMD works)";
    homepage = "https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
# vs plugins for RIFE interpolation

# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchurl }:

let
  version = "r9_mod_v33";
  src = fetchurl {
    url = "https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan/releases/download/${version}/librife_linux_x86-64.so";
    hash = "sha256-GKAKXjrJCl38/fhf24HZdzgaWiVgpMRdvppGnQB7GIY=";
  };
in
{
  inherit version src;
}

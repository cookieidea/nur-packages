# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchzip }:

let
  version = "unstable-2026-08-31";
  rev = "8b7ff6dcc85bc9935789c799e63f1388dfbd1bd4";
  src = fetchzip {
    url = "https://codeload.github.com/AkarinVS/vapoursynth-plugin/tar.gz/8b7ff6dcc85bc9935789c799e63f1388dfbd1bd4";
    hash = "sha256-azo5iD1gvGaMkIdRV7ZX2KQxEJ61B1j7mrhVdtrfarE=";
    extension = "tar.gz";
  };
in
{
  inherit version rev src;
}

# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchzip }:

let
  version = "unstable-2026-08-31";
  rev = "198cc7814c93209e23f1c6a20daffd651945ba2b";
  src = fetchzip {
    url = "https://codeload.github.com/VFR-maniac/L-SMASH-Works/tar.gz/198cc7814c93209e23f1c6a20daffd651945ba2b";
    hash = "sha256-eQ2FnUceFPk84QewkNhGfoEoQK3WcapY8f0SFGDOaN0=";
    extension = "tar.gz";
  };
in
{
  inherit version rev src;
}

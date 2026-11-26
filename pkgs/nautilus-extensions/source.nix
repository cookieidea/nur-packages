# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchgit }:

let
  version = "0.5.0";
  rev = "e834b762f662a2e62131ca188cbf98e6ab04679d";
  src = fetchgit {
    url = "https://github.com/Ameen-Sha-Cheerangan/nautilus-image-converter-gnome43plus";
    inherit rev;
    hash = "sha256-4QfXKAwZXzJNHT4oFEbFf9dLjI0PE0FI1MwHYu/Rh7k=";
    fetchSubmodules = false;
  };
in
{
  inherit version rev src;
}

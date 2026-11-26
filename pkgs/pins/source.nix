# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchgit }:

let
  version = "2.4.5-unstable-2026-08-12";
  rev = "d1b7bace3307d5723522045df36d8f823af02d48";
  src = fetchgit {
    url = "https://github.com/fabrialberio/Pins";
    inherit rev;
    hash = "sha256-fRHx+97itr4I30rNqK/PViUViVU7wRhAqVmAfTNuolc=";
    fetchSubmodules = false;
  };
in
{
  inherit version rev src;
}

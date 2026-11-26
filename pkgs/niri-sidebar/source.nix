# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchgit }:

let
  version = "0.3.0-unstable-2026-08-12";
  rev = "954f62e7e395ae14f01af582296e25a548133dc0";
  src = fetchgit {
    url = "https://github.com/Vigintillionn/niri-sidebar";
    inherit rev;
    hash = "sha256-MYP1ZiwV9+yJhl0zpuri6NQkQHlaYZjGBhXpZEaPZyI=";
    fetchSubmodules = false;
  };
in
{
  inherit version rev src;
}

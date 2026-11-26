{ pkgs }:

# niri-sidebar（Rust）。
let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = pkgs.callPackage ./source.nix { };
in
pkgs.rustPlatform.buildRustPackage (rec {
  pname = "niri-sidebar";
  inherit (source) version src;

  cargoLock.lockFile = "${src}/Cargo.lock";

  meta = {
    description = "A lightweight, external sidebar manager for the Niri window manager";
    homepage    = "https://github.com/Vigintillionn/niri-sidebar";
    license     = pkgs.lib.licenses.mit;
    mainProgram = "niri-sidebar";
    platforms   = pkgs.lib.platforms.linux;
  };
})

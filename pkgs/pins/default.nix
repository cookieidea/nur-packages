{ pkgs }:

# Pins：创建和编辑 .desktop 快捷方式。
let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = pkgs.callPackage ./source.nix { };
in
pkgs.stdenv.mkDerivation {
  pname = "pins";
  inherit (source) version src;

  nativeBuildInputs = [ pkgs.meson pkgs.ninja pkgs.pkg-config pkgs.wrapGAppsHook4 pkgs.desktop-file-utils ];
  buildInputs = [ pkgs.gtk4 pkgs.libadwaita ];

  meta = {
    description = "Create and edit app shortcuts (.desktop files)";
    homepage    = "https://github.com/fabrialberio/Pins";
    license     = pkgs.lib.licenses.gpl3Plus;
    mainProgram = "pins";
    platforms   = pkgs.lib.platforms.linux;
  };
}

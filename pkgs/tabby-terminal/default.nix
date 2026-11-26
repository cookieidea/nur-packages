# Tabby 终端（Electron；不同于 nixpkgs 的 TabbyML）。
{ pkgs }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = pkgs.callPackage ./source.nix { };
in
(pkgs.appimageTools.wrapType2 {
  pname = "tabby-terminal";
  inherit (source) version src;
  extraPkgs = pkgs: with pkgs; [ ];
}).overrideAttrs (old: {
  postInstall = (old.postInstall or "") + ''
    # 补充标准 desktop entry 路径。
    binname=$(basename "$(find "$out/bin" -maxdepth 1 -type f -executable | head -1)")
    mkdir -p "$out/share/applications" "$out/share/pixmaps"
    icon=$(find "$out" -path "*icons*" -name "*.png" 2>/dev/null | head -1)
    if [ -n "$icon" ]; then
      cp "$icon" "$out/share/pixmaps/tabby.png"
    fi
    cat > "$out/share/applications/tabby.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Tabby
Name[zh_CN]=Tabby 终端
Comment=Terminal emulator
Exec=$binname
Icon=tabby
Terminal=false
Categories=System;TerminalEmulator;
StartupWMClass=tabby
EOF
  '';
})

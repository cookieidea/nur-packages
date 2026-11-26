# PureVox（Nuitka 打包的单体二进制，Qt 静态链接）。
{ pkgs }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  # 上游资产名把 tag 里的日期重排（v2026.11.24.0119 →
  # PureVox-26.11.24-linux-x64.AppImage），模板表达不了，故用自定义 provider。
  source = pkgs.callPackage ./source.nix { };

  pname = "purevox";

  contents = pkgs.appimageTools.extract {
    inherit pname;
    inherit (source) version src;
  };
in
pkgs.appimageTools.wrapAppImage {
  inherit pname contents;
  inherit (source) version;

  # 二进制的 NEEDED 只有这些；Qt 是静态链接进单体二进制的。
  extraPkgs =
    p: with p; [
      libxcb
      libxkbcommon
      alsa-lib
      libGL
    ];

  # AppImage 自带 purevox.desktop 与 purevox.png，但 wrapAppImage 不会装它们，
  # 缺了桌面菜单里就找不到。
  extraInstallCommands = ''
    install -Dm444 ${contents}/purevox.desktop \
      $out/share/applications/purevox.desktop
    install -Dm444 ${contents}/purevox.png \
      $out/share/icons/hicolor/256x256/apps/purevox.png
    install -Dm444 ${contents}/purevox.png \
      $out/share/pixmaps/purevox.png
  '';

  meta = {
    description = "PureVox — 实时 AI 麦克风降噪";
    homepage = "https://github.com/a2heng/PureVox";
    license = pkgs.lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "purevox";
  };
}

# PureVox（Nuitka 打包的单体二进制，Qt 静态链接）。
{ pkgs }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  # 上游资产名把 tag 里的日期重排（v2026.11.24.0119 →
  # PureVox-26.11.24-linux-x64.AppImage），模板表达不了，故用自定义 provider。
  source = pkgs.callPackage ./source.nix { };
in
pkgs.appimageTools.wrapType2 {
  pname = "purevox";
  inherit (source) version src;

  # 二进制的 NEEDED 只有这些；Qt 是静态链接进单体二进制的。
  extraPkgs =
    p: with p; [
      libxcb
      libxkbcommon
      alsa-lib
      libGL
    ];

  meta = {
    description = "PureVox — 变声 / 语音处理工具";
    homepage = "https://github.com/a2heng/PureVox";
    license = pkgs.lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "purevox";
  };
}

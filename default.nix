# 自构建包。public 会作为 flake 的 packages 与 overlay 导出，
# internal 只供本仓库或主配置内部引用。
{ pkgs }:

let
  call = path: (import path { inherit pkgs; }).public or {};
in
{
  public = {
    # 桌面和窗口管理。
    niri-sidebar = import ./pkgs/niri-sidebar { inherit pkgs; };
    pins = import ./pkgs/pins { inherit pkgs; };
    nyxniri-scratch-menu = import ./pkgs/nyxniri-scratch-menu { inherit pkgs; };

    # 工具和网络。
    ab-download-manager = import ./pkgs/ab-download-manager { inherit pkgs; };
    astral = import ./pkgs/astral { inherit pkgs; };
    uuyc = import ./pkgs/uuyc { inherit pkgs; };

    # 影音和直播。
    obs-vdoninja = import ./pkgs/obs-vdoninja { inherit pkgs; };
    purevox = import ./pkgs/purevox { inherit pkgs; };

    # 游戏。
    bedrockboot = import ./pkgs/bedrockboot { inherit pkgs; };

    # 终端。
    tabby-terminal = import ./pkgs/tabby-terminal { inherit pkgs; };

    # 数据和字体。
    harmonyos-sans-sc = import ./pkgs/harmonyos-sans-sc { inherit pkgs; };

    # 文件管理器扩展。
    inherit (import ./pkgs/nautilus-extensions { inherit pkgs; })
      nautilus-image-converter
      nautilus-with-extensions;

    # VapourSynth 插件集：作为整体被 mpv 使用，属成品。
    inherit (import ./pkgs/vs-plugins { inherit pkgs; }) vapoursynth-with-plugins;
  };

  # 内部部件：只被上面的成品或主配置引用。
  internal = {
    inherit (import ./pkgs/vs-plugins { inherit pkgs; })
      l-smash
      vapoursynth-lsmash
      vapoursynth-akarin
      vapoursynth-rife-ncnn
      k7sfunc;

    inherit (import ./pkgs/mark-shot-python { inherit pkgs; })
      markShotOcr
      markShotScan
      markShotOcrHelper
      markShotScanHelper;
  };
}

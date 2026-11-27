# mark-shot 的扫码 Python 环境，供 activation 生成的 helper 使用。
# （OCR 自 mark-shot 0.2.5 起改为内置 ONNX Runtime 实现，不再需要 Python 环境。）
{ pkgs }:

# 需要 rec：helper 包引用同级的 markShotScan
rec {
  # 扫码：zxing-cpp + Pillow + NumPy。
  markShotScan = pkgs.python3.withPackages (ps: with ps; [
    zxing-cpp
    pillow
    numpy
  ]);

  # helper 入口：把扫码 Python 环境包装成可执行脚本，
  # 供 activation 安装到 ~/.local/share/mark-shot/。
  # （OCR 自 mark-shot 0.2.5 起改为内置实现，不再需要 Python 环境。）
  markShotScanHelper = pkgs.runCommand "mark-shot-scan-helper" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
    mkdir -p $out/bin
    cat > $out/bin/code-scan-helper.py <<'PY'
${builtins.readFile ./code-scan-helper.py}
PY
    chmod +x $out/bin/code-scan-helper.py
    wrapProgram $out/bin/code-scan-helper.py --set PATH ${markShotScan}/bin
  '';
}

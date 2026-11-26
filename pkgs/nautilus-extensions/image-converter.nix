# Nautilus Image Converter（GTK4）。
{ pkgs }:
let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = pkgs.callPackage ./source.nix { };
in
pkgs.stdenv.mkDerivation rec {
  pname = "nautilus-image-converter";
  inherit (source) version src;

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    gettext
  ];

  buildInputs = with pkgs; [
    gtk4
    glib
    nautilus
  ];

  # 使用 Nix store 中的 convert。
  postPatch = ''
    substituteInPlace meson.build --replace-fail \
      "nautilus_extension_dir = libnautilus_extension.get_pkgconfig_variable('extensiondir')" \
      "nautilus_extension_dir = join_paths(get_option('prefix'), 'lib', 'nautilus', 'extensions-4')"
    substituteInPlace src/nautilus-image-resizer.c src/nautilus-image-rotator.c src/nautilus-image-format-changer.c \
      --replace-fail '/usr/bin/convert' '${pkgs.imagemagick}/bin/convert'
    # 补充 UI 翻译标记。
    sed -i -E 's|<property name="(label\|title)">|<property name="\1" translatable="yes">|g' \
      data/nautilus-image-resize.ui data/nautilus-image-rotate.ui data/nautilus-image-format-change.ui
    # 使用维护版本的 UI，统一表单列宽。
    cp ${./ui}/nautilus-image-resize.ui data/nautilus-image-resize.ui
    cp ${./ui}/nautilus-image-rotate.ui data/nautilus-image-rotate.ui
    cp ${./ui}/nautilus-image-format-change.ui data/nautilus-image-format-change.ui
  '';

  # 中文翻译。
  postInstall = ''
    mkdir -p $out/share/locale/zh_CN/LC_MESSAGES
    msgfmt -o $out/share/locale/zh_CN/LC_MESSAGES/nautilus-image-converter.mo \
      ${./zh_CN.po}
  '';

  meta = with pkgs.lib; {
    description = "Nautilus extension to resize, rotate, convert and compress images (GTK4)";
    homepage = "https://github.com/Ameen-Sha-Cheerangan/nautilus-image-converter-gnome43plus";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}

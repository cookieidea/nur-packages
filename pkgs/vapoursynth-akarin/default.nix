{ lib, stdenv, fetchzip, meson, ninja, pkg-config, vapoursynth }:

let
  # 版本与哈希由 nix-repin 从 source.ts 生成。
  source = import ./source.nix { inherit fetchzip; };
in
stdenv.mkDerivation rec {
  pname = "vapoursynth-akarin";
  inherit (source) version src;

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];


  # meson 默认装到 vapoursynth 的插件目录（store 只读）→ 改装到自己
  postPatch = ''
    # 用内置 asmjit 后端
    substituteInPlace meson.build --replace-fail "use_asmjit = false" "use_asmjit = true"
    # 装到 $out/lib/vapoursynth
    sed -i "s|install_dir: join_paths.*|install_dir: 'lib/vapoursynth',|" meson.build
  '';

  meta = with lib; {
    description = "AkarinVS VapourSynth plugin (Expr / akarin namespace)";
    homepage = "https://github.com/AkarinVS/vapoursynth-plugin";
    license = licenses.free;
    platforms = platforms.linux;
  };
}

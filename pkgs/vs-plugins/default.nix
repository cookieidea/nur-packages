{ pkgs }:

# 各插件已拆到独立目录（便于 nix-repin 按 pkgs/*/source.ts 更新），
# 这里只做聚合，得到可直接给 mpv 用的 vapoursynth 插件集。
rec {
  l-smash = pkgs.callPackage ../l-smash { };
  vapoursynth-lsmash = pkgs.callPackage ../vapoursynth-lsmash { inherit l-smash; };
  vapoursynth-akarin = pkgs.callPackage ../vapoursynth-akarin { };
  vapoursynth-rife-ncnn = pkgs.callPackage ../vapoursynth-rife-ncnn { };
  k7sfunc = pkgs.python3Packages.callPackage ../k7sfunc { };

  vapoursynth-with-plugins = pkgs.callPackage ./with-plugins.nix {
    inherit vapoursynth-lsmash vapoursynth-akarin vapoursynth-rife-ncnn k7sfunc;
  };
}

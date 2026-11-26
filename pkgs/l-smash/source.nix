# 由 nix-repin 从 source.ts 生成。此版本为手写占位，CI 首次运行后会覆盖。

{ fetchzip }:

let
  version = "2.14.5";
  rev = "v2.14.5";
  src = fetchzip {
    url = "https://codeload.github.com/l-smash/l-smash/tar.gz/v2.14.5";
    hash = "sha256-Su1zNlFGZG6FV2jIfxkRQAAFSXEkqNxKk8VTmqjXUTI=";
    extension = "tar.gz";
  };
in
{
  inherit version rev src;
}

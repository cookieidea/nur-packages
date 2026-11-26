import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { defineSource, nix } from "nix-repin";

// PureVox 的 release 资产名把版本号里的日期重排了：
//   tag   v2026.11.24.0119
//   asset PureVox-26.11.24-linux-x64.AppImage
// 模板占位符表达不了这个映射，所以用自定义 provider。
const repository = "a2heng/PureVox";

type Release = { tag_name: string };

export default defineSource(async (source) => {
  const token = process.env.GITHUB_TOKEN ?? process.env.GH_TOKEN;
  const response = await fetch(
    `https://api.github.com/repos/${repository}/releases/latest`,
    {
      headers: {
        accept: "application/vnd.github+json",
        ...(token ? { authorization: `Bearer ${token}` } : {}),
      },
    },
  );
  if (!response.ok) {
    throw new Error(`GitHub API ${response.status} for ${repository}`);
  }

  const { tag_name: tag } = (await response.json()) as Release;
  const version = tag.replace(/^v/, "");

  const [year = "", month = "", day = ""] = version.split(".");
  const date = `${year.slice(2)}.${month}.${day}`;
  const url = `https://github.com/${repository}/releases/download/${tag}/PureVox-${date}-linux-x64.AppImage`;

  // 版本没变就跳过，避免每次 CI 都重新算哈希。
  // 注意不能用 source.readSourceFile：它要求 provider 先设置 archive 源，
  // 而自定义 provider 没有，会抛 "provider requires an archive source"。
  const current = await readFile(
    join(source.packageDirectory, "source.nix"),
    "utf8",
  ).catch(() => undefined);
  if (await source.shouldSkip(() => current?.includes(`"${version}"`) ?? false)) {
    return;
  }

  const { hash } = await nix.prefetch(url);

  return {
    "source.nix": nix.renderSource(
      ["fetchurl"],
      { version },
      `  src = fetchurl {
    url = "${url}";
    hash = "${hash}";
  };`,
    ),
  };
});

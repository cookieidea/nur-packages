# cookieidea 的自构建 Nix 包

NixOS 主配置（[neko-nixos](https://github.com/cookieidea/neko-nixos)）用的自建包都在这里，
与系统配置解耦，便于单独构建和更新。

## 用法

作为 flake input：

```nix
{
  inputs.neko-pkgs.url = "github:cookieidea/nur-packages";
  inputs.neko-pkgs.inputs.nixpkgs.follows = "nixpkgs";
}
```

然后通过 overlay 引入：

```nix
nixpkgs.overlays = [ inputs.neko-pkgs.overlays.default ];
```

或直接引用某个包：

```nix
inputs.neko-pkgs.packages.${system}.ab-download-manager
```

## 自动更新

带 `source.ts` 的包由 [nix-repin](https://github.com/so1ve/nix-repin) 生成
`source.nix`（版本 / URL / 哈希三者同源，不会出现改了两个漏一个的情况）。

更新在 CI 里执行，本地无需构建：

- **每日定时**：`.github/workflows/update.yml`（04:17 UTC）
- **手动触发**：Actions → 更新包源 → Run workflow（可指定包名）

手动跑（需本地有 nix）：

```sh
nix run .#update              # 全部
nix run .#update -- foo bar   # 指定包
nix run .#update -- --force   # 强制重新生成
```

**不要手改 `source.nix`** —— 它由 CI 覆盖。要改上游来源请编辑同目录的 `source.ts`。

## 包一览

| 包 | 上游 | 自动更新 |
|---|---|---|
| `ab-download-manager` | amir1376/ab-download-manager | ✅ |
| `astral` | AstralNext/Astral | ✅ |
| `bedrockboot` | Round-Studio/BedrockBoot | ✅ |
| `niri-sidebar` | Vigintillionn/niri-sidebar | ❌ 待接入 |
| `obs-vdoninja` | steveseguin/ninja-obs-plugin | ✅ |
| `pins` | fabrialberio/Pins | ❌ 待接入 |
| `purevox` | a2heng/PureVox | ❌ 待接入（asset 名含日期） |
| `tabby-terminal` | Eugeny/tabby | ✅ |
| `vapoursynth-rife-ncnn` | styler00dollar/VapourSynth-RIFE-ncnn-Vulkan | ❌ 待接入 |
| `k7sfunc` | hooke007/K7sfunc | ❌ 待接入 |
| `l-smash` | l-smash/l-smash | ❌ 待接入 |
| `vapoursynth-akarin` | AkarinVS/vapoursynth-plugin | ❌ 待接入 |
| `vapoursynth-lsmash` | VFR-maniac/L-SMASH-Works | ❌ 待接入 |
| `nautilus-image-converter` | Ameen-Sha-Cheerangan/nautilus-image-converter-gnome | ❌ 待接入 |
| `harmonyos-sans-sc` | 华为官方字体 | ❌ 手动 |
| `nyxniri-scratch-menu` | 本地 | ❌ |
| `uuyc` | 本地 | ❌ |
| `nautilus-with-extensions` | 本地包装 | ❌ |
| `vapoursynth-with-plugins` | 本地包装 | ❌ |
| `mark-shot-*` | 本地脚本改造 | ❌ |

## 许可

本仓库的打包代码为 MIT。各上游软件遵循其自身许可。

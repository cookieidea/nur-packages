{
  description = "cookieidea 的自构建 Nix 包";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # 从 TypeScript 定义生成 source.nix（版本/URL/哈希），避免三者不同步。
    nix-repin = {
      url = "github:so1ve/nix-repin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nix-repin,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        packages = import ./default.nix { inherit pkgs; };
      in
      {
        packages = packages.public // packages.internal;

        # 分组视图：主配置按 public/internal 分类引用，接口与原先的
        # configuration/pkgs 保持一致。
        publicPackages = packages.public;
        internalPackages = packages.internal;

        # `nix run .#update` 更新所有带 source.ts 的包，也可指定包名。
        apps.update = nix-repin.apps.${system}.default;

        formatter = pkgs.nixfmt-tree;
      }
    )
    // {
      overlays.default = final: _prev: (import ./default.nix { pkgs = final; }).public;
    };
}

import { github } from "nix-repin";

// 上游只用 "stable" 这个滚动 tag 标记可用版本，直接跟随。
export default github.branch({
  repository: "VFR-maniac/L-SMASH-Works",
  branch: "master",
});

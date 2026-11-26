import { github } from "nix-repin";

// 上游没有打 tag，跟随默认分支。
export default github.branch({
  repository: "Ameen-Sha-Cheerangan/nautilus-image-converter-gnome43plus",
  branch: "main",
});

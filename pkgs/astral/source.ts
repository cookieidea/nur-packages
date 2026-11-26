import { github } from "nix-repin";

export default github.release({
  repository: "AstralNext/Astral",
  stripPrefix: "v",
  assets: {
    "x86_64-linux": "astral-{version}-linux-x64.tar.gz",
  },
});

import { github } from "nix-repin";

export default github.release({
  repository: "steveseguin/ninja-obs-plugin",
  stripPrefix: "v",
  assets: {
    "x86_64-linux": "obs-vdoninja-linux-x86_64.tar.gz",
  },
});

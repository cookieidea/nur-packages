import { github } from "nix-repin";

export default github.release({
  repository: "Eugeny/tabby",
  stripPrefix: "v",
  assets: {
    "x86_64-linux": "tabby-{version}-linux-x64.AppImage",
  },
});

import { github } from "nix-repin";

export default github.release({
  repository: "Round-Studio/BedrockBoot",
  stripPrefix: "v",
  assets: {
    "x86_64-linux": "BedrockBoot-x86_64-linux.AppImage",
  },
});

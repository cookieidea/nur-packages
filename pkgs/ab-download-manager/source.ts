import { github } from "nix-repin";

export default github.release({
  repository: "amir1376/ab-download-manager",
  stripPrefix: "v",
  assets: {
    "x86_64-linux": "ABDownloadManager_{version}_linux_x64.tar.gz",
    "aarch64-linux": "ABDownloadManager_{version}_linux_arm64.tar.gz",
  },
});

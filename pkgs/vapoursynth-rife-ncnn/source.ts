import { github } from "nix-repin";

export default github.release({
  repository: "styler00dollar/VapourSynth-RIFE-ncnn-Vulkan",
  assets: {
    "x86_64-linux": "librife_linux_x86-64.so",
  },
});

import { github } from "nix-repin";

export default github.tag({
  repository: "l-smash/l-smash",
  stripPrefix: "v",
  tagPattern: "v[0-9]+\\.[0-9]+(\\.[0-9]+)?",
});

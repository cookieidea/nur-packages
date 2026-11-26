import { github } from "nix-repin";

export default github.tag({
  repository: "fabrialberio/Pins",
  stripPrefix: "v",
  tagPattern: "v[0-9]+\\.[0-9]+\\.[0-9]+",
});

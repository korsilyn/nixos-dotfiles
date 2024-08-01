{
  # Explicitly import "parts" of a flake to compose it modularly. This
  # allows me to import each part to construct the "final flake" instead
  # of declaring everything from a single, convoluted file.
  # By convention, things that would usually go to flake.nix should
  # have its own file in the `flake/` directory.
  imports = [
    ./apps # "Runnables" exposed by the flake, used with `nix run .#<appName`
    ./templates # Templates for initiating flakes with `nix flake init -t ...`

    ./args.nix # Args for the flake, consumed or propagated to parts by flake-parts
  ];
}

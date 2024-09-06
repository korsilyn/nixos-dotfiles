{
  description = "Python Project Template";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    poetry2nix,
    ...
  }: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      p2nix = poetry2nix.lib.mkPoetry2Nix {inherit pkgs;};
    in {
      default = p2nix.mkPoetryApplication {
        projectDir = self;
        preferWheels = true;
      };
    });

    devShells = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      p2nix = poetry2nix.lib.mkPoetry2Nix {inherit pkgs;};
    in {
      default = pkgs.${system}.mkShellNoCC {
        packages = with pkgs.${system}; [
          (p2nix.mkPoetryEnv { projectDir = self; })
          poetry
        ];
      };
    });
  };
}

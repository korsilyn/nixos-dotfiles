{
  description = "NixOS configuration by korsilyn";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Main repo

    hardware.url = "github:nixos/nixos-hardware"; # Hardware gimmicks
    impermanence.url = "github:nix-community/impermanence"; # Sometimes XD

    # Manage dotfiles
    homix = {
      url = "github:sioodmy/homix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # a tree-wide formatter (nix fmt)
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configure neovim nix way
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
        };
      };

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });
}

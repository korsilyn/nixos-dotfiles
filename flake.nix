{
  # Inspired by:
  # https://github.com/sioodmy/dotfiles
  # https://github.com/NotAShelf/nyx
  description = "NixOS configuration by korsilyn";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Main repo
    nixos-hardware.url = "github:nixos/nixos-hardware"; # Hardware gimmicks
    nix-colors.url = "github:Misterio77/nix-colors"; # Theming

    # Core of flake
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Manage dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim via Nix
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        treefmt-nix.follows = "treefmt-nix";
        devshell.follows = "devshell";
        nix-darwin.follows = "";
      };
    };

    # Tree formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Schizophrenic Firefox configuration
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
        systems.follows = "systems";
        flake-compat.follows = "flake-compat";
        nixpak.follows = "nixpak";
      };
    };

    # Some inputs just to follow them
    systems.url = "github:nix-systems/default-linux";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = [ "x86_64-linux" ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });
}

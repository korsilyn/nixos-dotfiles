{
  # Inspired by:
  # https://github.com/sioodmy/dotfiles
  # https://github.com/NotAShelf/nyx
  # https://github.com/Misterio77/nix-config
  description = "NixOS configuration by korsilyn";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Main repo
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05"; # Backup stable repo
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware"; # Hardware gimmicks

    nix-colors.url = "github:Misterio77/nix-colors"; # Theming

    # Manage dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage secrets
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    # Declaratively install FF addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, systems, ...} @ inputs:
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    hmModules = import ./modules/home-manager;

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # Gemini stars
    nixosConfigurations = {
      # Main desktop (alpha gem), Ryzen 5600G + RX6700XT
      castor = lib.nixosSystem {
        modules = [./hosts/castor];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Home laptop (beta gem), Ryzen 5500U
      pollux = lib.nixosSystem {
        modules = [./hosts/pollux];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Work laptop (gamma gem), Intel i5-1155G7
      alhena = lib.nixosSystem {
        modules = [./hosts/alhena];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # Standalone HM
    homeConfiguration = {
      # Main desktop (alpha gem), Ryzen 5600G + RX6700XT
      "korsilyn@castor" = lib.homeManagerConfiguration {
        modules = [./homes/korsilyn/castor.nix ./homes/korsilyn/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # Home laptop (beta gem), Ryzen 5500U
      "korsilyn@pollux" = lib.homeManagerConfiguration {
        modules = [./homes/korsilyn/pollux.nix ./homes/korsilyn/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # Work laptop (gamma gem), Intel i5-1155G7
      "korsilyn@alhena" = lib.homeManagerConfiguration {
        modules = [./homes/korsilyn/alhena.nix ./homes/korsilyn/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}

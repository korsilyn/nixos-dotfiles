{
  description = "NixOS + Flakes config by korsilyn";

  inputs = {
     nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
     nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";
     home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-2405, home-manager, nur, ... } @ inputs:
    let
      system = "x86_64-linux";
      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            # General configuration (users, networking, sound, etc)
            ./modules/system/configuration.nix
            # Hardware config (bootloader, kernel modules, filesystems, etc)
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                # Home manager config (configures programs like firefox, zsh, eww, etc)
                users.korsilyn = (./. + "/hosts/${hostname}/user.nix");
              };
              nixpkgs.overlays = [
                # Add nur overlay for Firefox addons
                nur.overlay
                (import ./overlays)
              ];
            }
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        # Gemini stars
        pollux = mkSystem inputs.nixpkgs "x86_64-linux" "pollux"; # Main PC
        castor = mkSystem inputs.nixpkgs "x86_64-linux" "castor"; # Main laptop
        alhena = mkSystem inputs.nixpkgs "x86_64-linux" "alhena"; # Work laptop
      };
    };
}

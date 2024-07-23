{
  description = "NixOS configuration by korsilyn";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Project shells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Formatters
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Pre-commit hooks
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wallpapers to catppuchin theme
    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        {
          config._module.args._inputs = inputs // {inherit (inputs) self;};
        }

        #inputs.flake-parts.flakeModules.easyOverlay
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        inputs',
        config,
        pkgs,
        ...
      }: {
        pre-commit = {
          settings.excludes = ["flake.lock"];
          settings.hooks = {
            alejandra.enable = true;
            prettier.enable = true;
          };
        };
        devShells.default = let
          extra = import ./devShell;
        in
          inputs'.devshell.legacyPackages.mkShell {
            name = "dotfiles";
            commands = extra.shellCommands;
            env = extra.shellEnv;
            packages = with pkgs; [
              config.treefmt.build.wrapper
              nil # nix ls
              alejandra # nix formatter
              git
              glow # .md viewer
              statix # lints and suggestions
              deadnix # clean unused nix code
            ];
          };

        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            black.enable = true;
            deadnix.enable = true;
            shellcheck.enable = true;
            shfmt = {
              enable = true;
              indent_size = 4;
            };
          };
        };
      };

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });
}

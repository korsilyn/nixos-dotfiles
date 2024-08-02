{
  withSystem,
  inputs,
  lib,
  ...
}: { 
  flake.nixosConfigurations = let
    inherit (inputs) self nixpkgs;
    inherit (lib) concatLists flatten singleton;

    ## flake inputs ##
    hw = inputs.nixos-hardware.nixosModules;
    agenix = inputs.agenix.nixosModules.default;
    hm = inputs.home-manager.nixosModules.home-manager;
    nixvim = inputs.nixvim.homeManagerModules.nixvim;

    modulePath = ../modules;
    coreModules = modulePath + /core; # Core system modules
    options = modulePath + /options; # System options
    shared = [ agenix ];

    common = coreModules + /common; # Defaults for ALL systems
    profiles = coreModiles + /profiles; # Defaults for system PROFILE

    ## ROLES ##
    workstation = coreModules + /roles/headless; # Workstation device
    graphical = coreModules + /roles/graphical; # GUI
    laptop = coreModules + /roles/laptop; # Additional power optimisation for battery life TODO
    headless = coreModules + /roles/headless; # NO GUI TODO
    server = coreModules + /roles/server; # Server config TODO

    ## Home-manager ##
    homesPath = ../homes;
    homes = [hm homesPath];

    core = modulePath + /core;
    boot = modulePath + /core/boot;
    docker = modulePath + /apps/docker.nix;
    vmware = modulePath + /apps/vmware.nix;
    wayland = modulePath + /wayland;


    shared = [boot core];

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {
        inherit inputs;
        inherit self;
      };
      users.korsilyn = {
        imports = [ nixvim ../homes ];
        _module.args.theme = import ../homes/theme;
      };
    };

    # Funcs (+rep NotAShelf/nyx)
    # mkNixosSystem is a convenient wrapper around lib.nixosSystem (which itself is a wrapper around lib.evalModules)
    # that allows us to abstract host creation and configuration with necessary modules and specialArgs pre-defined
    # or properly overridden compared to their nixpkgs default. This allows us to swiftly bootstrap a new system
    # when (not if) a new system is added to `hosts/default.nix` with minimum lines of code rewritten each time.
    # Ultimately this defines specialArgs we need and lazily merges any args and modules the host may choose
    # to pass to the builder.
    mkNixosSystem = {
      withSystem,
      system,
      hostname,
      ...
    } @ args:
      withSystem system ({
        inputs',
        self',
        ...
      }:
        lib.nixosSystem {
          # specialArgs
          specialArgs = recursiveUpdate {
            inherit (self) keys;
            inherit lib;
            inherit inputs self inputs' self';
          } (args.specialArgs or {});

          # Modules
          modules = concatLists [
            (singleton {
            networking.hostName = args.hostname;
            nixpkgs = {
              hostPlatform = mkDefault args.system;
              flake.source = nixpkgs.outPath;
            };
          })

          # if host needs additional modules, append them
          (args.modules or [])
        ];
      });
    # A variant of mkModuleTree that provides more granular control over the files that are imported.
    # While `mkModuleTree` imports all Nix files in the given directory, `mkModuleTree'` will look
    # for a specific
    mkModuleTree' = {
      path,
      ignoredPaths ? [],
    }: (
      # Two conditions fill satisfy filter here:
      #  - The path should end with a module.nix, indicating
      #   that it is in fact a module file.
      #  - The path is not contained in the ignoredPaths list.
      # If we cannot satisfy both of the conditions, then the path will be ignored
      filter (hasSuffix "module.nix") (
        map toString (
          filter (path: !elem path ignoredPaths) (listFilesRecursive path)
        )
      )
    );
    # mkModulesFor generates a list of modules to be imported by any host with
    # a given hostname. Do note that this needs to be called *in* the nixosSystem
    # set, since it generates a *module list*, which is also expected by system
    # builders.
    mkModulesFor = hostname: {
      moduleTrees ? [options common profiles],
      roles ? [],
      extraModules ? [],
    } @ args:
      flatten (
        concatLists [
          # Derive host specific module path from the first argument of the
          # function. Should be a string, obviously.
          (singleton ./${hostname}/host.nix)

          # Recursively import all module trees (i.e. directories with a `module.nix`)
          # for given moduleTree directories, and in addition, roles.
          (map (path: mkModuleTree' {inherit path;}) (concatLists [moduleTrees roles]))

          # And append any additional lists that don't don't conform to the moduleTree
          # API, but still need to be imported somewhat commonly.
          args.extraModules
        ]
      );
in {
  # Stars in Gemini
  # Main PC (alpha gem)
  castor = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "castor";}
      ./castor
      wayland
      docker
      hm
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Main laptop (beta gem)
  pollux = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "pollux";}
      ./pollux
      wayland
      docker
      hm
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Work laptop (gamma gem)
  alhena_old = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "alhena";}
      ./alhena
      wayland
      docker
      vmware
      hm
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };

  alhena = mkNixosSystem {
    inherit withSystem;
    hostname = "alhena";
    system = "x86_64-linux";
    modules = mkModulesFor "alhena" {
      roles = [ graphical workstation laptop ];
      extraModules = [ shared homes ];
    };
  };
};
}

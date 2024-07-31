{
  withSystem,
  inputs,
  lib,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (lib.lists) concatLists flatten singleton;
    inherit (lib) mkDefault recursiveUpdate filter hasSuffix elem;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (inputs) self nixpkgs;

    ## flake inputs ##
    hw = inputs.nixos-hardware.nixosModules; # hardware compat for pi4 and other quirky devices
    agenix = inputs.agenix.nixosModules.default; # secret encryption via age
    hm = inputs.home-manager.nixosModules.home-manager; # home-manager nixos module

    # Specify root path for the modules. The concept is similar to modulesPath
    # that is found in nixpkgs, and is defined in case the modulePath changes
    # depth (i.e modules becomes nixos/modules).
    modulePath = ../modules;

    coreModules = modulePath + /core; # the path where common modules reside
    extraModules = modulePath + /extra; # the path where extra modules reside
    options = modulePath + /options; # the module that provides the options for my system configuration

    ## common modules ##
    # The opinionated defaults for all systems, generally things I want on all hosts
    # regardless of their role in the general ecosystem. E.g. both servers and workstations
    # will share the defaults below.
    common = coreModules + /common; # the self-proclaimed sane defaults for all my systems
    profiles = coreModules + /profiles; # force defaults based on selected profile

    ## roles ##
    # Roles either provide an additional set of defaults on top of the core module
    # or override existing defaults for role-specific optimizations.
    headless = coreModules + /roles/headless; # for devices that are of the headless type - provides no GUI
    graphical = coreModules + /roles/graphical; # for devices that are of the graphical type - provides a GUI
    workstation = coreModules + /roles/workstation; # for devices that are of workstation type - any device that is for daily use
    server = coreModules + /roles/server; # for devices that are of the server type - provides online services
    laptop = coreModules + /roles/laptop; # for devices that are of the laptop type - provides power optimizations

    # extra modules - optional but likely critical to a successful build
    sharedModules = extraModules + /shared; # the path where shared modules reside

    # home-manager #
    homesPath = ../homes; # home-manager configurations for hosts that need home-manager
    homes = [hm homesPath]; # combine hm flake input and the home module to be imported together

    # a list of shared modules that ALL systems need
    shared = [
      sharedModules # consume my flake's own nixosModules
      agenix # age encryption for secrets
    ];

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

            # set baseModules in the place of nixos/lib/eval-config.nix's default argument
            # _module.args.baseModules = import "${modulesPath}/module-list.nix";
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
    # Gemini stars BTW
    # My main desktop boasting a RX 6700XT and a Ryzen 5 5600G
    castor = mkNixosSystem {
      inherit withSystem;
      hostname = "castor";
      system = "x86_64-linux";
      modules = mkModulesFor "castor" {
        roles = [graphical workstation];
        extraModules = [shared homes];
      };
    };

    # My main laptop with a Ryzen 5 5500U
    pollux = mkNixosSystem {
      inherit withSystem;
      hostname = "pollux";
      system = "x86_64-linux";
      modules = mkModulesFor "pollux" {
        roles = [graphical workstation laptop];
        extraModules = [shared homes];
      };
    };

    # My work laptop with a Intel i5-1155G7
    alhena = mkNixosSystem {
      inherit withSystem;
      hostname = "alhena";
      system = "x86_64-linux";
      modules = mkModulesFor "alhena" {
        roles = [graphical workstation laptop];
        extraModules = [shared homes];
      };
    };
  };
}

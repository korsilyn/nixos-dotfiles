{self, ...}: let
  mkFlakeModule = path:
    if builtins.isPath path
    then self + path
    else builtins.throw "${path} is not a real path! Are you stupid?";
in {
  flake = {
    # set of modules exposed by my flake to be consumed by others
    # those can be imported by adding this flake as an input and then importing the nixosModules.<moduleName>
    # i.e imports = [ inputs.nyx.nixosModules.steam-compat ]; or modules = [ inputs.nyx.nixosModules.steam-compat ];
    nixosModules = {
      # a module for the comma tool that wraps it with nix-index and disabled the command-not-found integration
      comma-rewrapped = mkFlakeModule /modules/extra/shared/nixos/comma;

      # we do not want to provide a default module
      default = builtins.throw "There is no default module, sorry!";
    };

    homeManagerModules = {
      # again, we do not want to provide a default module
      default = builtins.throw "There is no default module, sorry!";
    };
  };
}

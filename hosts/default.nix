{
  withSystem,
  inputs,
  lib,
  ...
}: { flake.nixosConfigurations = let
  inherit (inputs) self nixpkgs;

  modulePath = "../modules";
  core = modulePath + /core;
  boot = modulePath + /core/boot;
  docker = modulePath + /apps/docker.nix;
  vmware = modulePath + /apps/vmware.nix;
  wayland = modulePath + /wayland;

  ## flake inputs ##
  hw = inputs.nixos-hardware.nixosModules;
  agenix = inputs.agenix.nixosModules.default;
  hm = inputs.home-manager.nixosModules.home-manager;
  nixvim = inputs.nixvim.homeManagerModules.nixvim;

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
in {
  # Stars in Gemini
  # Main PC (alpha gem)
  castor = nixpkgs.lib.nixosSystem {
    inherit withSystem;
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
    inherit withSystem;
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
  alhena = nixpkgs.lib.nixosSystem {
    inherit withSystem;
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
};
}

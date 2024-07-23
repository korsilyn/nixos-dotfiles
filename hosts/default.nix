{
  self,
  nixpkgs,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  boot = ../system/core/boot;
  docker = ../system/apps/docker.nix;
  vmware = ../system/apps/vmware.nix;
  wayland = ../system/wayland;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [boot core];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.korsilyn = {
      imports = [../home];
      _module.args.theme = import ../home/theme;
    };
  };
in {
  # Stars in Gemini
  # Main PC (alpha gem)
  castor = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "castor";}
      ./castor
      hmModule
      wayland
      docker
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
      hmModule
      wayland
      docker
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Work laptop (gamma gem)
  alhena = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "alhena";}
      ./alhena
      hmModule
      wayland
      docker
      vmware
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };

  # VM (delta gem)
  wasat = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "wasat";}
      ./wasat
      vmware
      wayland
      hmModule
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };
}

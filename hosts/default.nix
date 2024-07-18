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

  shared = [boot core];
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
      wayland
      docker
      vmware
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
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };
}

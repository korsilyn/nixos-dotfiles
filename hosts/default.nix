{
  self,
  nixpkgs,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  boot = ../system/core/boot;
  virtualisation = ../system/core/virtualisation.nix;
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
      virtualisation
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
      virtualisation
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
      virtualisation
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
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };
}

{
  nixpkgs,
  self,
  ...
} @ inputs: let
  inherit (self) inputs;
  core = ../system/core; # Apps, services, security
  gaming = ../system/core/gaming; # Steam, lutris, mangohud, etc.
  # Home manager
  hm = inputs.home-manager.nixosModules.home-manager;
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.korsilyn = {
      imports = [ ../system/homes ];
    };
  };
  # DE
  sway = ../system/core/wm/sway.nix;
  # Per device optimizations
  amd_gpu = ../system/devices/amd_gpu.nix;
  intel_igpu = ../system/devices/intel_igpu.nix;
  hw = inputs.nixos-hardware.nixosModules;

  shared = [core hm];
in {
  # Stars in Gemini
  # Main PC (alpha gem)
  castor = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "castor";}
      ./castor
      gaming
      sway
      amd_gpu
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
      gaming
      sway
      amd_gpu
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
      sway
      intel_igpu
      { inherit home-manager; }
    ]
    ++ shared;
    specialArgs = {inherit inputs;};
  };
}

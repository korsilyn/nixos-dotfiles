{
  self,
  nixpkgs,
  ...
}: let
  inherit (self) inputs;
  common = ../modules/common;
  hw = inputs.hardware.nixosModules;
  homix = inputs.homix.nixosModules.default;
  hm = inputs.home-manager.nixosModules.home-manager;
  nixvim = inputs.nixvim.nixosModules.nixvim;
  shared = [common homix hm nixvim];
in {
  # Gemini stars
  # Main desktop (alpha gem), Ryzen 5600G + RX6700XT
  castor = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "alhena";}
        ./castor
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Home laptop (beta gem), Ryzen 5500U
  pollux = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "alhena";}
        ./pollux
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Work laptop (gamma gem), Intel i5-1155G7
  alhena = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "alhena";}
        ./alhena
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.korsilyn = import ../modules/common/home.nix;
        }
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}

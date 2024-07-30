{
  imports = [
    ./fs
    ./modules

    ./btrfs.nix
    ./networking.nix
  ];

  config = {
    system.stateVersion = "24.05";
  };
}

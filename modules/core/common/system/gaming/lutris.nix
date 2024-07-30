{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config) modules;

  prg = modules.system.programs;
in {
  config = mkIf prg.gaming.lutris.enable {
    environment.systemPackages = [
      pkgs.lutris
    ];
  };
}

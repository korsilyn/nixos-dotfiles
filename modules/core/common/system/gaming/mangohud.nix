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
  config = mkIf prg.gaming.mangohud.enable {
    environment.systemPackages = [
      pkgs.mangohud
    ];
  };
}

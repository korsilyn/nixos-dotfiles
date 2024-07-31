{
  osConfig,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf prg.vesktop.enable {
    home.packages = with pkgs; [vesktop];
  };
}

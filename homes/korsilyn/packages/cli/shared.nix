{
  osConfig,
  lib,
  pkgs,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.system.programs;
in {
  config = mkIf prg.cli.enable {
    home.packages = with pkgs; [
      # packages from inputs
      inputs'.agenix.packages.default

      # CLI packages from nixpkgs
      duf
      dust
      btop
      lm_sensors

      file
      p7zip

      ripgrep
      fd
      sd
      bat
      eza

      curlie

      dconf

      cht-sh
    ];
  };
}

{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  prg = config.modules.system.programs;
in {
  config = mkIf prg.gaming.steam.enable {
    programs.steam = {
      # Enable steam
      enable = true;

      # Whether to open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;

      # Whether to open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = false;

      # Compatibility tools to install
      # For the accepted format (and the reason behind)
      # the "compattool" attribute, see:
      # <https://github.com/NixOS/nixpkgs/pull/296009>
      extraCompatPackages = [
        pkgs.proton-ge-bin.steamcompattool
      ];
    };
  };
}

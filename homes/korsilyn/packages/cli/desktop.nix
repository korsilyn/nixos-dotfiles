{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.system.programs;
  dev = modules.device;
  acceptedTypes = ["desktop" "laptop"];
in {
  config = mkIf ((builtins.elem dev.type acceptedTypes) && prg.cli.enable) {
    home.packages = with pkgs; [
      # CLI
      libnotify
      brightnessctl
      pamixer
      nix-tree
    ];
  };
}

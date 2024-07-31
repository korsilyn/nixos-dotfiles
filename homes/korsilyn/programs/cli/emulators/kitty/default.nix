{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;

  dev = modules.device;
  acceptedTypes = ["laptop" "desktop"];
in {
  config = mkIf (builtins.elem dev.type acceptedTypes) {
    programs.kitty = {
      enable = true;
    };
    xdg.configFile."kitty".source = ./kitty;
  };
}

{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  dev = osConfig.modules.device;
  env = osConfig.modules.usrEnv;
  acceptedTypes = ["laptop" "desktop"];
in {
  config = mkIf ((builtins.elem dev.type acceptedTypes) && env.isWayland) {
    home.packages = with pkgs; [
      # CLI
      grim
      slurp
      wl-clipboard
      wf-recorder
    ];
  };
}

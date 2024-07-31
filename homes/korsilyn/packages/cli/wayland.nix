{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  dev = osConfig.modules.device;
  env = osConfig.modules.usrEnv;
  meta = osConfig.meta;
  acceptedTypes = ["laptop" "desktop"];
in {
  config = mkIf ((builtins.elem dev.type acceptedTypes) && meta.isWayland) {
    home.packages = with pkgs; [
      # CLI
      grim
      slurp
      wl-clipboard
      wf-recorder
    ];
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  sys = config.modules.system;
in {
  config = mkIf sys.video.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}

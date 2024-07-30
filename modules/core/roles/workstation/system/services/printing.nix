{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
in {
  config = mkIf sys.printing.enable {
    # enable cups and hp drivers
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [
          hplip
        ];
      };
    };
  };
}

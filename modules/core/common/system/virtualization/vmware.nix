{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system.virtualization;
in {
  config = mkIf sys.vmware.enable {
    virtualisation.vmware.host.enable = true;
  };
}

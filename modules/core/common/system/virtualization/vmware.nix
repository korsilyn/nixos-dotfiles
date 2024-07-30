{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
in {
  config = mkIf sys.virtualization.vmware.host.enable {
    virtualization.vmware.host.enable = true;
  };
}

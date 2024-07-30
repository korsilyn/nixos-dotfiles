{lib, ...}: let
  inherit (lib) mkService;
  inherit (lib.options) mkEnableOption;
in {
  imports = [
    ./databases.nix
    ./monitoring.nix
  ];

  options.modules.system = {
    services = {
      nginx = mkService {
        name = "Nginx";
        type = "webserver";
      };
    };
  };
}

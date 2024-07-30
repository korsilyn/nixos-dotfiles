{
  config,
  lib,
  ...
}: let
  inherit (lib) mkAgenixSecret;
  inherit (lib.strings) optionalString;

  sys = config.modules.system;
  cfg = sys.services;
in {
  age.identityPaths = [
    "${optionalString sys.impermanence.home.enable "/persist"}/home/korsilyn/.ssh/id_ed25519"
  ];
}

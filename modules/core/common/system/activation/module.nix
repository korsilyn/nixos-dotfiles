{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  system.activationScripts = {
    # if system declares that it wants closure diffs, then run the diff script on activation
    # this is useless if you are using nh, which does this for you in a different way
    diff = mkIf config.modules.system.activation.diffGenerations {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "=== diff to current-system ==="
          ${pkgs.nvd}/bin/nvd --nix-bin-dir='${config.nix.package}/bin' diff /run/current-system "$systemConfig"
          echo "=== end of the system diff ==="
        fi
      '';
    };
  };
}

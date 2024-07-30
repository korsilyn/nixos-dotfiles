{lib, ...}: let
  inherit (lib.modules) mkForce;
  inherit (lib.attrsets) mapAttrs;
in {
  systemd = let
    timeoutConfig = ''
      DefaultTimeoutStartSec=10s
      DefaultTimeoutStopSec=10s
      DefaultTimeoutAbortSec=10s
      DefaultDeviceTimeoutSec=10s
    '';
  in {
    # Set the default timeout for starting, stopping, and aborting services to
    # avoid hanging the system for too long on boot or shutdown.
    extraConfig = timeoutConfig;
    user.extraConfig = timeoutConfig;
  };
}

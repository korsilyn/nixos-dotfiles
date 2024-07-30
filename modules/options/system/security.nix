{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
in {
  options.modules.system.security = {
    fprint.enable = mkEnableOption "Fingerprint reader service";

    selinux = {
      enable = mkEnableOption "system SELinux support + kernel patches";
      state = mkOption {
        type = with types; enum ["enforcing" "permissive" "disabled"];
        default = "enforcing";
        description = ''
          SELinux state to boot with. The default is enforcing.
        '';
      };

      type = mkOption {
        type = with types; enum ["targeted" "minimum" "mls"];
        default = "targeted";
        description = ''
          SELinux policy type to boot with. The default is targeted.
        '';
      };
    };

    auditd = {
      enable = mkEnableOption "the audit daemon.";
      autoPrune = {
        enable = mkEnableOption "auto-pruning of old audit logs.";

        size = mkOption {
          type = types.int;
          default = 524288000; # roughly 500 megabytes
          description = "The maximum size of the audit log in bytes. The default is 500MBs";
        };

        dates = mkOption {
          type = types.str;
          default = "daily";
          example = "weekly";
          description = "How often cleaning is triggered. Passed to systemd.time";
        };
      };
    };
  };
}

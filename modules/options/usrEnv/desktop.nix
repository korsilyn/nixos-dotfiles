{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool enum package;

  cfg = config.modules.usrEnv;
  sys = config.modules.system;
in {
  options.modules.usrEnv = {
    desktop = mkOption {
      type = enum ["none" "sway" "i3"];
      default = "none";
      description = ''
        The desktop environment to be used.
      '';
    };
    desktops = {
      sway = {
        enable = mkOption {
          type = bool;
          default = cfg.desktop == "sway";
          description = ''
            Whether to enable Sway wayland compositor.

            Will be enabled automatically when `modules.usrEnv.desktop`
            is set to "sway".
          '';
        };

        package = mkOption {
          type = package;
          default = pkgs.sway;
          description = ''
            The Sway package to be used.
          '';
        };
      };

      i3 = {
        enable = mkOption {
          type = bool;
          default = cfg.desktop == "i3";
          description = ''
            Whether to enable i3 window manager

            Will be enabled automatically when `modules.usrEnv.desktop`
            is set to "i3".
          '';
        };

        package = mkOption {
          type = package;
          default = pkgs.i3;
          description = ''
            The i3 package to be used.
          '';
        };
      };
    };

    useHomeManager = mkOption {
      type = bool;
      default = true;
      description = ''
        Whether to enable the usage of home-manager for user home
        management. My home-manager module will map the list of users to
        their home directories inside the `homes/` directory in the
        repository root.

        ::: {.warning}
        Username via `modules.system.mainUser` must be set if
        this option is enabled.
        :::
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.useHomeManager -> sys.mainUser != null;
        message = "modules.system.mainUser must be set while modules.usrEnv.useHomeManager is enabled";
      }
    ];
  };
}

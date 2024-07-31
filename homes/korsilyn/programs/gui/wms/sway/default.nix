{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  env = osConfig.modules.usrEnv;
in {
  config = mkIf env.desktops.sway.enable {
    wayland.windowManager.sway = {
      enable = true;
    };
    xdg.configFile."sway".source = ./sway;
  };
}

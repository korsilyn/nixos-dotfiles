{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (osConfig.modules.style.colorScheme) colors;

  env = modules.usrEnv;
in {
  config = mkIf env.programs.screenlock.swaylock.enable {
    programs.swaylock = {
      enable = true;
    };
    xdg.configFile."swaylock".source = ./swaylock;
  };
}

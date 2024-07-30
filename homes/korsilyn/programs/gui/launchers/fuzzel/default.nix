{
  config,
  lib,
  pkgs,
  osConfig,
  inputs',
  ...
}: let
  inherit (lib) mkIf optionals;
  inherit (osConfig) modules meta;

  env = modules.usrEnv;
in {
  config = mkIf env.programs.launchers.fuzzel.enable {
    programs.rofi = {
      enable = true;
    };
    xdg.configFile."fuzzel".source = ./fuzzel;
  };
}

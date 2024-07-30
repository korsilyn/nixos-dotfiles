{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (config) modules;

  prg = modules.system.programs;
in {
  options.modules.usrEnv.programs.gaming = {
    enable = mkEnableOption "userspace gaming programs" // {default = prg.gaming.enable;};
    mangohud.enable = mkEnableOption "MangoHud overlay" // {default = prg.gaming.enable;};
  };
}

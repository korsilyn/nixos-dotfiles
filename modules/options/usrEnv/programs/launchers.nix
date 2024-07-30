{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.usrEnv.programs.launchers = {
    fuzzel.enable = mkEnableOption "fuzzel application launcher";
  };
}

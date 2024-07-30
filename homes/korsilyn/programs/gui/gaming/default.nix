{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  env = modules.usrEnv;
  prg = env.programs;
in {
  imports = [
    ./mangohud.nix
  ];

  config = mkIf prg.gaming.enable {
    home.packages = with pkgs; [
      # runtime
      mono # general dotnet apps
      winetricks # wine helper utility
    ];
  };
}

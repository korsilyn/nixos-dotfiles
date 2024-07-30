{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe mkGraphicalService;
  inherit (osConfig) modules meta;

  env = modules.usrEnv;
in {
  config = mkIf (meta.isWayland && (env.desktop != "Hyprland")) {
    systemd.user.services = {
      swaybg = mkGraphicalService {
        Unit.Description = "Wallpaper chooser service";
        Service = let
          wall = builtins.fetchurl {
            url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/1023077979591cdeca76aae94e0359da1707a60e/minimalistic/darker_unicat.png";
            sha256 = "sha256-8+G/KY84WOfPhALqB+yzsc+yJ69IItdLaWro07jx0ls=";
          };
        in {
          ExecStart = "${getExe pkgs.swaybg} -i ${wall}";
          Restart = "always";
        };
      };
    };
  };
}

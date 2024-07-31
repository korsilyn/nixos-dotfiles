{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) modules meta;

  env = modules.usrEnv;
in {
  # Temp fix
  config = mkIf (false && meta.isWayland && (env.desktop != "Hyprland")) {
    systemd.user.services = {
      swaybg = {
        Unit.Description = "Wallpaper chooser service";
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];
        Service = let
          wall = builtins.fetchurl {
            url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/1023077979591cdeca76aae94e0359da1707a60e/minimalistic/darker_unicat.png";
            sha256 = "sha256-19y89f97jid9yw4kzvxIrria171npcqbph9i8azyvm8x3xy9s4fd";
          };
        in {
          ExecStart = "${getExe pkgs.swaybg} -i ${wall}";
          Restart = "always";
        };
      };
    };
  };
}

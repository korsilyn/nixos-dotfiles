{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) meta;
in {
  config = mkIf meta.isWayland {
    systemd.user.services = {
      cliphist = {
        Unit.Description = "Clipboard history service";
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];
        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${getExe pkgs.cliphist} store";
          Restart = "always";
        };
      };

      wl-clip-persist = {
        Unit.Description = "Persistent clipboard for Wayland";
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];
        Service = {
          ExecStart = "${getExe pkgs.wl-clip-persist} --clipboard both";
          Restart = "always";
        };
      };
    };
  };
}

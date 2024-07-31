{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
  env = config.modules.usrEnv;
  meta = config.meta;
in {
  config = mkIf (sys.video.enable && meta.isWayland) {
    environment.etc."greetd/environments".text = ''
      ${lib.optionalString (env.desktop == "Hyprland") "Hyprland"}
      ${lib.optionalString (env.desktop == "sway") "SwayWM"}
      zsh
    '';

    environment = {
      variables = {
        _JAVA_AWT_WM_NONEREPARENTING = "1";
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = "wayland,x11";
        ANKI_WAYLAND = "1";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        SDL_VIDEODRIVER = "x11";
        CLUTTER_BACKEND = "wayland";
      };
    };
  };
}

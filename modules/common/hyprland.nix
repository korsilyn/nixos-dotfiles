{pkgs, ...}: {
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
  services = {
    hypridle.enable = true;
  };
  # TODO review
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    XDG_SESSION_TYPE = "wayland";
  };
  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprcursor
    pamixer
    brightnessctl
    wl-clipboard
    polkit_gnome
    tela-circle-icon-theme
    fuzzel
    kitty
    mako
    grimblast
    cliphist
  ];

  # Polkit daemon
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}

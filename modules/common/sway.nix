{pkgs, ...}: {
  environment = {
    variables = {
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
    systemPackages = with pkgs; [
      pamixer
      brightnessctl
      wl-clipboard
      lxqt.lxqt-policykit
      tela-circle-icon-theme
    ];
  };
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaybg
      autotiling
      fuzzel
      kitty
      waybar
      mako
      grim
      slurp
    ];
  };
  #programs.waybar.enable = true;
}

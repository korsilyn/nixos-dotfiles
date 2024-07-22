{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./wm.nix
    ./fonts.nix
    ./services.nix
    ./pipewire.nix
    ./bluetooth.nix
    ./apps.nix
  ];
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

  hardware = {
    graphics.enable = true;
    pulseaudio.support32Bit = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      sway = {
        default = [
          "wlr"
        ];
        "org.freedesktop.impl.portal.Settings" = [
          "wlr"
          "gtk"
        ];
      };
    };
  };

  #sound = {
  #  enable = true;
  #  mediaKeys.enable = true;
  #};
}

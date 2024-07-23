{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./wm.nix
    ./fonts.nix
    ./theme.nix
    ./services.nix
    ./pipewire.nix
    ./bluetooth.nix
    ./apps.nix
    ./development.nix
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

  #sound = {
  #  enable = true;
  #  mediaKeys.enable = true;
  #};
}

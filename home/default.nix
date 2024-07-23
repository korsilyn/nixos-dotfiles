{ config, pkgs, ...}: {
  home.username = "korsilyn";
  home.homeDirectory = "/home/korsilyn";
  programs.home-manager.enable = true;
  imports = [
    ./apps
    ./dotfiles
  ];

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
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
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.stateVersion = "24.05";
}

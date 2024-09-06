{ inputs, pkgs, ...}: {
  config.home.username = "korsilyn";
  config.home.homeDirectory = "/home/korsilyn";
  config.programs.home-manager.enable = true;
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.schizofox.homeManagerModule
    ./apps
    ./dotfiles
  ];

  config.xdg = {
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

  config.home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  config.home.stateVersion = "24.05";
}

{
  # Catppuccin config
  catppuccin = {
    accent = "mauve";
    flavor = "mocha";
    pointerCursor.enable = true;
  };

  # Cursor fix
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.x11.enable = true;
  home.pointerCursor.size = 24;

  # GTK
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      icon.enable = true;
    };
  };

  # QT
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      catppuccin.enable = true;
    };
  };
}

{
  # Catppuccin config
  catppuccin = {
    accent = "mauve";
    flavor = "mocha";
    pointerCursor.enable = true;
  };

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

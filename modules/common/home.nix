{
  home = {
    username = "korsilyn";
    homeDirectory = "/home/korsilyn";
    stateVersion = "24.05";
  };

  # Dotfiles
  imports = [../config];

  programs.home-manager.enable = true;
}

{
  home = {
    username = "korsilyn";
    homeDirectory = "/home/korsilyn";
    stateVersion = "24.05";
  };

  imports = [
    ./home # Home config
    ../config # Dotfiles
  ];

  programs.home-manager.enable = true;
}

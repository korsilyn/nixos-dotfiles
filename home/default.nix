{ config, ...}: {
  home.username = "korsilyn";
  home.homeDirectory = "/home/korsilyn";
  programs.home-manager.enable = true;
  imports = [
    ./apps
    ./dotfiles
  ];
  home.stateVersion = "24.05";
}

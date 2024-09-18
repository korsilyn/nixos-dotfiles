{
  # files in ~/.config/
  xdg.configFile = {
    "bat".source = ./bat;
    "btop".source = ./btop;
    "fastfetch".source = ./fastfetch;
    "fuzzel".source = ./fuzzel;
    #homix.".config/htop".source = ./htop;
    "hypr".source = ./hypr;
    #xdg.configFile."imv".source = ./imv;
    "kitty".source = ./kitty;
    "mako".source = ./mako;
    #xdg.configFile."MangoHud".source = ./MangoHud;
    #xdg.configFile."nekoray".source = ./nekoray; # + config file
    # xdg.configFile."neofetch".source = ./neofetch;
    # xdg.configFile."pipewire".source = ./pipewire;
    #xdg.configFile."qt5ct".source = ./qt5ct;
    #xdg.configFile."qt6ct".source = ./qt6ct;
    # xdg.configFile."river".source = ./river;
    #xdg.configFile."scripts".source = ./scripts;
    #xdg.configFile."steamtinkerlaunch".source = ./steamtinkerlaunch;
    #homix.".config/sway".source = ./sway;
    #homix.".config/swayidle".source = ./swayidle;
    #homix.".config/swaylock".source = ./swaylock;
    "waybar".source = ./waybar;
    #xdg.configFile."wireplumber".source = ./wireplumber;
  };

  # files in ~/
  home.file = {
    ".zshrc".source = ./zsh/zshrc;
    ".p10k.zsh".source = ./zsh/p10k.zsh;
    ".zprofile".source = ./zsh/zprofile;
  };
}

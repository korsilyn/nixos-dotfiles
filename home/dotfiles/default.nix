{ config, pkgs, ...}: {
  # files in ~/.config/
  xdg.configFile."bat".source = ./bat;
  xdg.configFile."btop".source = ./btop;
  xdg.configFile."fastfetch".source  = ./fastfetch;
  xdg.configFile."fuzzel".source = ./fuzzel;
  xdg.configFile."htop".source = ./htop;
  # xdg.configFile."hypr".source = ./hypr;
  xdg.configFile."imv".source = ./imv;
  xdg.configFile."kitty".source = ./kitty;
  xdg.configFile."mako".source = ./mako;
  xdg.configFile."MangoHud".source = ./MangoHud;
  xdg.configFile."nekoray".source = ./nekoray; # + config file
  # xdg.configFile."neofetch".source = ./neofetch;
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."pipewire".source = ./pipewire;
  xdg.configFile."qt5ct".source = ./qt5ct;
  xdg.configFile."qt6ct".source = ./qt6ct;
  # xdg.configFile."river".source = ./river;
  xdg.configFile."scripts".source = ./scripts;
  xdg.configFile."StardewValley".source = ./StardewValley; # tmp
  xdg.configFile."steamtinkerlaunch".source = ./steamtinkerlaunch;
  xdg.configFile."sway".source = ./sway;
  xdg.configFile."swayidle".source = ./swayidle;
  xdg.configFile."swaylock".source = ./swaylock;
  xdg.configFile."waybar".source = ./waybar;
  xdg.configFile."wireplumber".source = ./wireplumber;

  # files in ~/
  home.file.".zshrc".source = ./zsh/zshrc;
  home.file.".p10k.zsh".source = ./zsh/p10k.zsh;
}

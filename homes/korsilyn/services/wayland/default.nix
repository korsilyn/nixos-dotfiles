{ config, ...}: {
  xdg.configFile."mako".source = ./mako;
  xdg.configFile."swayidle".source = ./swayidle;
  imports = [
    ./clipboard
    ./swaybg
  ];
}

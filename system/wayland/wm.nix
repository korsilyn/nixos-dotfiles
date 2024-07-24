{ pkgs, ... }: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaybg
      autotiling
      fuzzel
      kitty
      waybar
      mako
    ];
  };
  #programs.waybar.enable = true;
}

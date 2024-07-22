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
      dunst
      waybar
    ];
  };
  #programs.waybar.enable = true;
}

{ pkgs, ... }: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      fuzzel
      kitty
      dunst
    ];
  };
  programs.waybar.enable = true;
}

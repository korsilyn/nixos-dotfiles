{ pkgs, username, ... }:
{
  # ---- System Configuration ----
  programs = {
    htop.enable = true;
    git.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

}

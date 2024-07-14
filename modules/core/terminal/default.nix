{ pkgs, username, ... }:
{
  # ---- System Configuration ----
  programs = {
    htop.enable = true;
    git.enable = true;
  };

  environment.systemPackages = [
    curl
    wget
  ];

}

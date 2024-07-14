{ pkgs, username, ... }
{
  system = {
    stateVersion = "24.05";
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  home-manager = {
    backupFileExtension = "backup";
    users.${username} = {
      # The home.stateVersion option does not have a default and must be set
      home.stateVersion = "24.05";
      nixpkgs.config.allowUnfree = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}

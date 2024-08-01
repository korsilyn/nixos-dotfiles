{ ... }: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    nix-direnv.enable = true;
  };
}

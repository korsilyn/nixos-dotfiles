{
  programs = {
    ssh = {
      enable = true;
      hashKnownHosts = true;
      compression = true;
      matchBlocks = let
        commonIdFile = "~/.ssh/id_ed25519";
      in {
        "aur" = {
          hostname = "aur.archlinux.org";
        };

        "github" = {
          hostname = "github.com";
        };
      };
    };
  };
}

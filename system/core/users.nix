{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.homix.nixosModules.default
  ];

  programs.zsh.enable = true;
  users.users = {
    korsilyn = {
      isNormalUser = true;
      # homix = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "docker"
        "systemd-journal"
        "audio"
        "video"
        "input"
        "networkmanager"
        "power"
        "nix"
      ];
      uid = 1000;
    };
  };
}

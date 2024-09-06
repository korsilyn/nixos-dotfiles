{ pkgs, config, lib, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.korsilyn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "network"
      "plugdev"
      "video"
      "wheel"
      "wireshark"
    ];

    packages = [pkgs.home-manager];
    hashedPasswordFile = config.sops.secrets.korsilyn-password.path;
    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../homes/korsilyn/ssh.pub);
  };

  sops.secrets.korsilyn-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.korsilyn = import ../../../../homes/korsilyn/${config.networking.hostName}.nix;

  security.pam.services = {
    swaylock = {};
  };
}

{ pkgs, config, lib, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  programs.zsh.enable = true;

  users = {
    mutableUsers = false;
    users.korsilyn = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ifTheyExist [
        "audio"
        "docker"
        "input"
        "git"
        "libvirtd"
        "lxd"
        "network"
        "networkmanager"
        "plugdev"
        "power"
        "systemd-journal"
        "video"
        "wheel"
      ];
      uid = 1000;
    };
  };
}

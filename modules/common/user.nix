{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  programs.zsh.enable = true;

  users = {
    mutableUsers = false;
    users.korsilyn = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$LC2eDV3/EXl9JJDcV04pH0$jbMXgkSGgDTJcQ4WDCmZ5Y6r45/bban2pUdhw0RMPc1";
      shell = pkgs.zsh;
      homix = true;
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

{
  keys,
  pkgs,
  ...
}: {
  users.users.korsilyn = {
    isNormalUser = true;

    # Home directory
    createHome = true;
    home = "/home/korsilyn";

    shell = pkgs.zsh;

    # Should be generated manually. See option documentation
    # for tips on generating it. For security purposes, it's
    # a good idea to use a non-default hash.
    initialPassword = "P@ssw0rd";
    openssh.authorizedKeys.keys = [keys.korsilyn];
    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "plugdev"
      "tss"
      "power"
      "nix"
      "network"
      "networkmanager"
      "wireshark"
      "mysql"
      "docker"
      "git"
      "libvirtd"
    ];
  };
}

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = [ "subvol=rootfs" "compress-force=zstd" "relatime" ];
  };

  fileSystems."/.swapvol" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = [ "subvol=swap" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [ "nosuid" "nodev" "noexec" "nosymfollow" "fmask=0077" "dmask=0077" "relatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = [ "subvol=home" "compress-force=zstd" "relatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress-force=zstd" "noatime" ];
  };

  swapDevices = [
    { device = "/.swapvol/swapfile"; }
  ];
}

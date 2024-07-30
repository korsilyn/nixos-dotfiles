{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/074272bf-559c-4348-80cb-8c3814a91c38";
      fsType = "btrfs";
      options = [ "subvol=rootfs" "compress-force=zstd" "noatime" "x-systemd.device-timeout=0" ];
    };

  fileSystems."/.swapvol" =
    { device = "/dev/disk/by-uuid/074272bf-559c-4348-80cb-8c3814a91c38";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3829-DD9F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/074272bf-559c-4348-80cb-8c3814a91c38";
      fsType = "btrfs";
      options = [ "subvol=home" "compress-force=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/074272bf-559c-4348-80cb-8c3814a91c38";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress-force=zstd" "noatime" ];
    };

  swapDevices = [ {
    device = "/.swapvol/swapfile";
    size = 16 * 1024;
  } ];
}

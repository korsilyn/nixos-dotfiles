{
  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=rootfs" "compress-force=zstd" "noatime" ];
    };

  fileSystems."/.swapvol" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=home" "compress-force=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress-force=zstd" "noatime" ];
    };

  swapDevices = [ {
    device = "/.swapvol/swapfile";
    size = 16 * 1024;
  } ];
}

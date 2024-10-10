{
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "vmd" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["kvm-intel" "xe"];
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["noatime" "discard"];
    };

    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["subvol=rootfs" "compress-force=zstd" "noatime" "discard"];
    };

    "/.swapvol" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime" "discard"];
    };

    "/home" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["subvol=home" "compress-force=zstd" "noatime" "discard"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["subvol=nix" "compress-force=zstd" "noatime" "discard"];
    };
  };

  swapDevices = [
    {
      device = "/.swapvol/swapfile";
      size = 16 * 1024;
    }
  ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}

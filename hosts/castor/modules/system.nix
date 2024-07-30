{
  config.modules.system = {
    mainUser = "korsilyn";
    fs.enabledFilesystems = ["btrfs" "vfat" "ext4" "f2fs" "ntfs" "exfat"];
    autoLogin = true;

    boot = {
      loader = "systemd-boot";
      kernel = pkgs.linuxPackages_xanmod_latest;
      plymouth.enable = true;
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      loadRecommendedModules = true;
      tmpOnTmpfs = true;
    };

    video.enable = true;
    sound.enable = true;
    bluetooth.enable = true;
    printing.enable = true;

    networking = {
      optimizeTcp = true;
      nftables.enable = true;
    };

    virtualization = {
      enable = true;
      docker.enable = true;
      qemu.enable = true;
      vmware.host.enable = false;
    };

    programs = {
      cli.enable = true;
      gui.enable = true;

      git.signingKey = "";

      gaming = {
        enable = true;
      };

      default = {
        terminal = "kitty";
      };
    };
  };
}

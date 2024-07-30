{ pkgs, ...}: {
  config.modules.system = {
    mainUser = "korsilyn";
    fs.enabledFilesystems = ["btrfs" "vfat" "exfat"];
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
    printing.enable = false;

    networking = {
      optimizeTcp = true;
      nftables.enable = true;
    };

    virtualization = {
      enable = true;
      docker.enable = true;
      qemu.enable = false;
      vmware.enable = true;
    };

    programs = {
      cli.enable = true;
      gui.enable = true;

      git.signingKey = "";

      gaming = {
        enable = false;
      };

      default = {
        terminal = "kitty";
      };
    };
  };
}

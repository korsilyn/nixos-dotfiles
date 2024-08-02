{ pkgs, ...}: {
  config.modules.system = {
    mainUser = "korsilyn";
    fs.enabledFilesystems = ["btrfs" "vfat" "exfat"]; # Only systems on that laptop

    boot = {
      loader = "systemd-boot";
      kernel = pkgs.linuxPackages_latest; # Always using latest Linux Kernel
      # plymouth.enable = true; # TODO
      # enableKernelTweaks = true; # TODO ???
      # initrd.enableTweaks = true; # TODO ???
      # loadRecommendedModules = true; # TODO ???
      tmpOnTmpfs = true;
    };

    # video.enable = true; # TODO ???
    sound.enable = true; # Pipewire + Wireplumber + qpwgraph
    # bluetooth.enable = true; # TODO ??? I already have this in config.device
    printing.enable = false;

    # networking = {
      # optimizeTcp = true; # TODO ???
      # nftables.enable = true; # TODO FW is good
    # };

    # virtualization = {
      # enable = false; # TODO ???
      # docker.enable = true; # TODO
      # qemu.enable = false; # TODO
      # vmware.enable = true; # TODO
    # };

    programs = {
      cli.enable = true;
      gui.enable = true;

      # git.signingKey = ""; # TODO Create key

      # gaming = {
        # enable = false; # TODO ??? I already have this in profile.nix
      # };

      # default = {
       # terminal = "kitty"; # TODO ??? Why i have it here? Move to module.usr maybe?
      # };
    };
  };
}

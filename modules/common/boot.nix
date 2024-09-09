{pkgs}: {
  boot = {
    tmp.useTmpfs = true;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [
      xpadneo
      zenpower
    ];
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        memtest86.enable = true;
        configurationLimit = 10;
        editor = false;
      };
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}

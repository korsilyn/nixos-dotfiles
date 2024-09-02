{
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [dconf udisks2];
    };
    irqbalance.enable = true;
    fstrim.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  zramSwap.enable = lib.mkDefault false;

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  environment.systemPackages = with pkgs; [
    git
    btrfs-progs
    cifs-utils
    appimage-run
  ];

  time = {
    timeZone = "Europe/Moscow";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };
  console = let
    variant = "u18n";
  in {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
    earlySetup = true;
    keyMap = "us";
  };

  boot.binfmt.registrations = lib.genAttrs ["appimage" "AppImage"] (ext: {
    recognitionType = "extension";
    magicOrExtension = ext;
    interpreter = "/run/current-system/sw/bin/appimage-run";
  });

  programs = {
    nano.enable = false;
    nix-ld.enable = true;
    fuse.userAllowOther = true;
  };

  systemd = {
    oomd.enableRootSlice = true;
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };
}

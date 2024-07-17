{
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [dconf udisks2];
    };
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
  };

  zramSwap.enable = lib.mkDefault false;

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs
    appimage-run
  ];

  time = {
    timeZone = "Europe/Moscow";
    hardwareClockInLocalTime = true;
  };

  i18n = let
    defaultLocale = "en_US.UTF-8";
    ru = "ru_RU.UTF-8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = ru;
      LC_IDENTIFICATION = ru;
      LC_MEASUREMENT = ru;
      LC_MONETARY = ru;
      LC_NAME = ru;
      LC_NUMERIC = ru;
      LC_PAPER = ru;
      LC_TELEPHONE = ru;
      LC_TIME = ru;
    };
  };
  console = let
    variant = "u24n";
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
    nix-ld.enable = true;
    fuse.userAllowOther = true;
  };

  systemd.oomd.enableRootSlice = true;
}

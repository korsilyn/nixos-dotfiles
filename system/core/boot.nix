{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  boot = {
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [
      xpadneo
      zenpower
    ];

    bootspec.enable = mkDefault true;
    loader = {
      systemd-boot = {
        enable = mkDefault true;
        memtest86.enable = true;
        configurationLimit = 10;
        editor = false;
      };
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}

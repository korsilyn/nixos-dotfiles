{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  environment.systemPackages = with pkgs; [
    sbctl # Secure Boot debugging
  ];
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
      systemd-boot.enable = mkDefault true;
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}

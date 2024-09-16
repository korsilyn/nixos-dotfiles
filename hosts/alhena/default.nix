{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop

    ./hardware-configuration.nix

    ../../modules/common

    ../../modules/optional/docker.nix
    ../../modules/optional/quietboot.nix
    ../../modules/optional/tlp.nix
    ../../modules/optional/vmware.nix
  ];

  networking.useDHCP = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.graphics = {
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver

  # Work certs and git settings (only for alhena)
  security.pki.certificateFiles = [
    ./work_certs/vsphere.pem
    #./work_certs/gitlab.pem
  ];
  programs.git = {
    config.user.email = lib.mkDefault "egladkov@ysts.ru";
  };

  system.stateVersion = "24.05";
}
